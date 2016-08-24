#The publisher tools representation of a word_document. 
# This has two main attributes, word_document and publisher_tools_config. 
# This provides us with a way to add publisher tools specific validations. 
# For example, it makes sure we don't make a previously paid doc free, 
# or have two documents with the same ISBN + publisher.
#
# This class is also what takes the import_data record and applies metadata (this happens in initialize)
class PublisherTools::Document
  def self.concerned_with(*concerns)
    concerns.each do |concern|
      require_dependency "#{name.underscore}/#{concern}"
    end
  end
  attr_accessor :word_document, :publisher_tools_config, :parsed, :sales_rights, :imported_fields, :savers, :bowker, :library_thing, :book, :import_data, :metadata, :import_record, :for_direct_purchase
  attr_accessor :prices_to_disable
  
  concerned_with :savers, :setters, :library_thing_saver
  #used in activeRecord validations
  def self.human_attribute_name(*args)
    return args.first
  end
  
  def new_record?
    if self.word_document
      self.word_document.new_record?
    else
      return true
    end
  end

include ACTIVE_MODEL_VALIDATION_CONST

###VALIDATIONS
  validate :parsed_successfully
  validate :word_document_found
  validate :cant_make_paid_doc_free
  validate :no_gaps_in_pricing
  validate :category_found
  validate :featured_collection_exists
  
  private
  def parsed_successfully
    return false unless parsed
    return true unless parsed.errors.present?
    parsed.errors.each do |field, message|
      self.errors.add(field, message)
    end
    return false
  end

  def skipped_pricing?
    !imported?(:pricing)
  end

  def no_gaps_in_pricing
    return true if self.prices.blank? || skipped_pricing?
    sorted = sort_pricing_models(self.prices)
    last_price = nil

    sorted.each do |price|
      #We don't care about problems in the past.
      next unless Date.today <= price.valid_until

      #Note: We're not breaking on error here on purpose, we want to show all gaps/overlaps so an admin can fix
      # instead of sending each one back individually.
      #There's a duplciate validation in the pricing model table, but this attempts to catch the errors before we get there.
      # if it fails we'll still fail, but it won't fail as nicely.
      if last_price
        countries_equal = last_price.country == price.country
        pm_type_equal = last_price.class == price.class
        if last_price.valid_until + 1 != price.valid_from && countries_equal && pm_type_equal
          self.errors.add(:price, "contains gaps: P1 ends on #{last_price.valid_until}, P2 starts on #{price.valid_from}")
        end
        if last_price.valid_until == price.valid_until && last_price.valid_from == price.valid_from && countries_equal && pm_type_equal
          self.errors.add(:price, "contains overlapping prices: P1 $#{last_price.model_price}, Country #{last_price.country}, P2 $#{price.model_price}, Country: #{price.country}")
        end
      end

      last_price = price
    end
    return errors.blank?
  end

  def cant_make_paid_doc_free
    return true if skipped_pricing?
    errors.add(:price, "No price specified.  Please set a price of 0 if this is supposed to be free.") if prices.blank?
    return if word_document.nil?

    if word_document.paid?
      message = "PublisherTools cannot make paid document #{word_document.id} free"
      if free?
        #It's not an error if the word document's paid document is free, and we're free.
        if word_document.paid_document.price == 0
          word_document.paid_document = nil if word_document.paid_document.new_record?
          return true
        else
          errors.add(:price, message)
        end
      elsif prices.blank?
        errors.add(:price, "Paid docs require a price. None were found.")
      elsif prices.any? {|price| price.retail_price == 0}
        errors.add(:price, message + " in the future")
      end
    end
  end

  def category_found
    if @category && @category_object.nil?
      errors.add(:category, "could not be found with name '#{@category}'")
    end
  end

  def featured_collection_exists
    if featured_collection.present?

    featured_collection_exists_in_my_collections =
      collections.present? && collections.include?(featured_collection)

      if !featured_collection_exists && featured_collection_object.nil?
        errors.add(:featured_collection, "A featured collection called #{featured_collection} does not exist for your user")
      end
    end
  end

  def word_document_found
    if word_document.nil?
      if publisher_tools_config.find_by_isbn?
        search_for = parsed.isbn
        search_by = "isbn"
      else
        search_for = parsed.filename
        search_by = "filename"
      end

      self.errors.add(:word_document, "Can't find doc '#{search_for}' by #{search_by}")
    end
  end
###VALIDATIONS

  public

  # fields that should prioritize bowker data
  BOWKER_FIELDS = [:page_count, :publish_date, :language, :audience, :book_publication_date, :alternate_isbns]

  def initialize(import_record, fields=[])
    @import_record = import_record    # used by to_json
    self.publisher_tools_config = import_record.publisher_tools_config
    self.parsed = import_record.parse_raw_metadata

    if !parsed
      import_record.add_error_message("No Metadata (too big to parse)")
      import_record.set_field_error(:metadata_status)
      import_record.save
      return
    end
    
    if import_record.word_document_id
      self.word_document = WordDocument.find(import_record.word_document_id)
    else
      self.word_document = get_single_document!
    end

    return if word_document.nil?

    # these on master finds are happening to ensure no concurrency issue can occur when querying/creating document_metadata,
    # and that @metadata is set to the definitively correct document_metadata
    word_document.document_metadata ||= word_document.build_document_metadata
    word_document.document_metadata.save!
    self.word_document = WordDocument.on_master.find(self.word_document.id)

    self.bowker = PublisherTools::BowkerDocument.new(self.isbn)
    self.library_thing = PublisherTools::LibraryThingDocument.new(self.isbn)

    @metadata = word_document.document_metadata
    @metadata.publisher_tools_import_data ||= {}

    @import_data = metadata.publisher_tools_import_data
    @imported_fields = MetadataParser::PublisherTools::Row::Base.fields.keys.dup
    @imported_fields = imported_fields & fields.collect(&:to_sym) if fields.present?
    import_pricing = @imported_fields.include?(:pricing)

    #We want to import pricing information first, because a few other importers rely on it existing.
    if import_pricing
      MetadataParser::PublisherTools::Row::Base.field_to_accessors(:pricing).each do |acc|
        set_field(acc)
        add_saver(acc)
      end
      add_saver(:pricing)
    end

    @imported_fields.each do |field|
      MetadataParser::PublisherTools::Row::Base.field_to_accessors(field).each do |acc|
        set_field(acc)
        add_saver(acc)
      end
      add_saver(field)
    end

    #Normally adding a saver checks if the field is blank, this always adds it.
    set_field_with_saver_and_default("authors", [])
    set_field_with_saver_and_default("bisac_categories", [])

    set_for_direct_purchase
    set_pmp
    set_offsite
  end

  def book
    @book ||= Book.find_or_initialize_by_word_document_id(word_document.id)
  end

  #Gets the single document associated with this import record.
  # Deletes the rest. 
  def get_single_document!
    docs = self.class.find_document(
        :search_by => publisher_tools_config.find_by_isbn? ? parsed.isbn : parsed.filename,
        :publisher_config => publisher_tools_config)
    docs = self.class.sort_docs(docs)
    ret_doc = docs.shift
    
    #Get rid of all docs except the one we're keeping around.
    self.class.delete_docs!(docs)

    return ret_doc
  end

  def add_saver(field)
    self.savers ||= []
    save_method = "save_#{field}"
    if self.respond_to?(save_method) && !self.savers.include?(save_method)
      self.savers.push(save_method)
    end
  end

  def set_field(field)
    #NOTE: NOT elsif. There are certain fields where the "set..." version sets default values
    # and the ='s version allows publishers to override those, if desired.
    if self.respond_to?("#{field}=")
      value = nil

      if BOWKER_FIELDS.include?(field)  
        bowker_val = bowker.send(field) 
        value = bowker_val if bowker_val.present?    # bowker returns '' rather than nil
      end

      value ||= parsed.send(field)     # If no bowker data, or non-bowker field, get value from parsed metadata
      self.send("#{field}=", value) if value.present? || value == false
    end

    if self.respond_to?("set_#{field}")
      self.send("set_#{field}")
    end
  end

  #This sets the field to a default value if it was not previously set. This is because
  # there are certain fields which don't exist in spreadsheet, but we still want to import them
  # for example, authors and bisac categories.
  def set_field_with_saver_and_default(field, default)
    return unless imported_fields.include?(field.to_sym)
    if self.send(field).blank?
      self.send("#{field}=", default)
    end
    add_saver(field)
  end

####GETTERS AND SETTERS
  # a document is free if the publisher has provided a single price of 0
  # publishers may also provide no price (defaulting to free for new documents, as
  # new uploads default to free.
  # any nonzero current price or any future price sets this to false
  def free?
    if prices.blank?
      !word_document.paid?
    else
      current_price.retail_price == 0 && prices.length == 1
    end
  end

  def paid?
    !free?
  end

  # this is nil if there is no valid current price (all prices are in the future)
  def current_price
    if @current_price.nil?
      today = Date.today
      if prices.present?
        prices.each do |price_data|
          if today.between?(price_data.valid_from.to_date, price_data.valid_until.to_date)
            @current_price = price_data 
            break
          end
        end
      end
    end
    @current_price
  end
  alias_method :price, :current_price

  attr_accessor :deleting, :filename, :collections, :flex_schema, :flex_columns,
    :page_restriction_type, :page_restriction_value
  alias_method :deleting?, :deleting
  #setters
  attr_reader :prices, :publish_date, :category, :list_price, :authors, :tags,
    :download_and_drm, :featured_collection, :bisac_categories

  def featured_collection=(featured_collection_name)
    @featured_collection = featured_collection.to_s.gsub(/\n/, '').strip
  end

  def featured_collection_object
    return nil if featured_collection.blank?
    @featured_collection ||= DocumentCollection.on_slow_slave.first(:conditions =>
      {:name => featured_collection, :word_user_id  => publisher_tools_config.word_user_id })
  end

  def paid_document
    if word_document.paid_document.blank?
      word_document.build_paid_document
      word_document.async_queue.reconvert_with_encrypted_text(true)
    end
    return word_document.paid_document
  end

  def to_json
    data = {}
    data[:import_record_id] = @import_record.id

    @imported_fields.each do |field|
      MetadataParser::PublisherTools::Row::Base.field_to_accessors(field).each do |acc| 
        data["#{acc}"] = self.parsed.send acc
      end
    end

    data.to_a.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_json
  end 

private
  def imported?(field)
    if field == :pricing || field == :prices || field == :list_price
      return imported_fields.include?(:prices) || imported_fields.include?(:list_price) || imported_fields.include?(:pricing)
    end
    return imported_fields.include?(field)
  end

  def parse_date(date)
    if date.is_a?(String)
      b = Book.new
      b.publication_date = date
      return b.approximate_publication_date
    else
      return date
    end
  end

  def with_retries options = {}, &block
    self.class.with_retries(options, &block)
  end

  def log_error(message, level="info")
    self.class.log_error(message, level)
  end
  
  def self.log_error(message, level="info")
    Scribd::Logger.for("publisher_tools_file_watcher").send(level, message)
  end

#Do we need with_retries?
  NUM_RETRIES = 5
  SLEEP_TIME = 3
  def self.with_retries options = {}
    num_retries = options[:num_retries] || NUM_RETRIES
    sleep_time = options[:sleep_time] || SLEEP_TIME
    sleep_time += rand # rand in place to help in the case of concurrent blocking
    unhandled_error = nil
    result = nil
    num_retries.times do
      begin
        result = yield
        break
      rescue => e
        if options[:on_error]
          unhandled_error = options[:on_error].call(e) 
          if unhandled_error.present?
            #Kill this if we got an unhandled error. 
            log_error "unhandled error with scribd: '#{e.inspect}' \n\n #{e.backtrace.join("\n")}"
            raise unhandled_error.inspect 
          end
          sleep(sleep_time)
        else
          log_error "unhandled error with scribd: '#{e.inspect}' \n\n #{e.backtrace.join("\n")}"
          raise e
        end
      end
    end
    result
  end

  def self.delete_docs!(docs)
    docs.each do |doc|
      doc.delete! unless doc.deleted_or_deleted_with_purchases?
    end
  end

  #Sorting: First come non-deleted, within that, sort by most purchases, if same #purchases, sort by
  #         created_at.
  def self.sort_docs(docs)
    docs.sort do |doc1, doc2| 
      
      if doc2.deleted_or_deleted_with_purchases? == doc1.deleted_or_deleted_with_purchases?
        res = 0 
      elsif !doc2.deleted_or_deleted_with_purchases? && doc1.deleted_or_deleted_with_purchases?
        res = 1
      else 
        res = -1
      end

      res = doc2.document_purchases.count <=> doc1.document_purchases.count if res == 0
      res = doc2.created_at <=> doc1.created_at if res == 0
      res
    end
  end

  # Required Params: publisher_config - Publisher config for the data-owner
  #                  search_by - what are we searching for the document by (should be a filename or isbn)?
  def self.find_document(opts = {})
    publisher_config, search_by = opts.values_at :publisher_config, :search_by
    raise ::PublisherTools::Error::ArgumentError.new("Publisher Config is missing in find_document")  unless publisher_config
    raise ::PublisherTools::Error::ArgumentError.new("Must pass search_by to find_document") unless search_by
    word_user = publisher_config.word_user
    find_by_isbn = publisher_config.find_by_isbn? 

    docs = if find_by_isbn
      all_by_isbn(search_by)
    else
      all_by_user_and_filename(word_user, search_by)
    end

    #docs.reject! {|doc| doc.deleted? || doc.document_metadata.try(:deleted_with_purchases) || doc.document_metadata.try(:publisher_tools_import_data).try(:[], :deleted_with_purchases)} unless include_deleted
    return docs
  end

  def self.all_by_isbn(isbn)
    idens = DocumentIdentifier.by_type_and_id(:isbn, isbn)
    docs = idens.collect &:word_document
  end

  def self.all_by_user_and_filename(word_user, file_name)
    return_docs = []
    file_name_without_ext = File.basename(file_name, ".*").downcase
    with_retries do
      docs = word_user.word_documents.on_slow_slave.find_in_batches(:conditions =>{:removal_id => 0}) do |docs|
        WordDocument.on_slow_slave.preload_associations(docs, :word_upload)
        docs.each do |d|
          next if d.word_upload.nil?
          original_filename = File.basename(d.word_upload.original_filename, ".*").downcase
          return_docs << d if !d.deleted? && original_filename == file_name_without_ext
        end #docs.each
      end #documents.find_in_batches
    end
 
    return_docs
  end

  def page_restriction_type
    @page_restriction_type || publisher_tools_config.page_restriction_type
  end
end
