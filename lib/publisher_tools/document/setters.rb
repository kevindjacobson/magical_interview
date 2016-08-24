class PublisherTools::Document
  attr_accessor :book_publication_date

  [ :description,
    :isbn,
    :buy_url
  ].each do |word_document_field|
    delegate "#{word_document_field}=", word_document_field, :to => :word_document
  end

  [ :page_count,
    :language
  ].each do |field|
    delegate field, :to => :book
  end

  [ :title,
    :subtitle,
  ].each do |field|
    delegate "#{field}=", field, :to => :book
  end

  def set_download_and_drm(new_download_and_drm=nil)
    @download_and_drm ||= new_download_and_drm || publisher_tools_config.download_and_drm

    with_retries do
      case @download_and_drm
        when 'download-pdf-orig'
          word_document.download_pdf_and_original!
        when 'view-only'
          word_document.download = false
        when 'download-pdf', 'download-epub'
          word_document.download_pdf_only!
        when 'view-without-copy-paste'
          word_document.download = false
          cd = word_document.controlled_document || word_document.build_controlled_document
          cd.disable_select_text = true
        when nil
          #Nothing.
        else
          raise "received an unsupported download-and-drm string"
      end
    end
    set_page_restrictions if page_restriction_type
    set_device_restrictions
    @download_and_drm
  end

  def set_prices
    retail_price = price.retail_price unless price.blank?
    paid_document.price = retail_price if retail_price
    if list_price.blank?
      paid_document.list_price = paid_document.price
    else
      paid_document.list_price = list_price * 100
    end

  end

  #This should be called late, only for paid docs.
  def set_page_restrictions
    return if free?
    type = page_restriction_type
    value = page_restriction_value
    paid_document.page_calculation_method = type unless type.nil?
    case paid_document.page_calculation_method
    when 'page_range'
      paid_document.page_range = value
    when 'max_percentage'
      paid_document.max_percentage_to_show = (value.blank? ? publisher_tools_config.max_percentage : (value.to_f < 1.0 ? value.to_f * 100 : value))
    when 'max_pages'
      paid_document.max_pages_to_show = (value.blank? ? publisher_tools_config.max_pages : value)
    end
  end

  def set_device_restrictions
    return if free?
    word_document.build_controlled_document if word_document.controlled_document.blank?
    word_document.controlled_document.max_applications_per_day = publisher_tools_config.max_applications_per_day
    word_document.controlled_document.max_devices_stored_on = publisher_tools_config.max_devices_stored_on
  end

  def set_pmp

    publish_price = [self.current_price.try(:retail_price), paid_document.try(:price)].compact.min

    publish_date = book_publication_date ? parse_date(book_publication_date) : nil
    word_document.set_pmp(publish_price, publish_date)
  end

  def set_offsite
    if publisher_tools_config.offsite_only?
      raise "pmp and offsite should not both be true" if paid_document.pmp?
      paid_document.offsite = true
    end
  end

  def set_for_direct_purchase
    if for_direct_purchase.present?
      paid_document.store = for_direct_purchase == 'Y' ? true : false
    elsif self.publisher_tools_config.not_sold_in_store?
      paid_document.store = false
    end
  end

  def set_flex_columns
    return unless flex_schema.present? && flex_columns.present?
    metadata.publisher_tools_custom_data ||= {}

    flex_schema.each_with_index do |key, index|
      metadata.publisher_tools_custom_data[key] = flex_columns[index]
    end
  end

  def add_identifier(identifier, type, source)
    @document_identifiers ||= []
    iden = DocumentIdentifier.find_or_initialize_by_identifier_and_word_document_id(identifier, self.word_document.id)
    if iden.new_record?
      iden.type = type
      iden.source = source
      iden.word_document = self.word_document
    end
    @document_identifiers.push(iden)
  end

  def alternate_isbns=(isbns)
    isbns.each do |isbn|
      add_identifier(isbn, :alternate_isbn, :publisher_tools)
    end
  end

  #prices= overwrites existing prices if they are set already
  # but list_price sets a default price in case prices= is never called
  def prices=(new_prices)
    return if new_prices.blank?

    seller = word_document.word_user.seller
    new_prices = clean_prices(new_prices)
    @prices_to_disable = word_document.pricing_models.active.try(:to_a)
    @prices_to_disable ||= []

    new_prices = new_prices.collect do |price|
      model_from_price(price, word_document, seller)
    end.flatten.compact

    new_prices = sort_pricing_models(new_prices)

    #Extend the last price until forever in the future.
    new_prices.last.valid_until = Payments::PricingModels::PricingModel::YEAR_FOREVER

    #Throw out any pricing models that ended in the past...
    new_prices.delete_if {|m| m.valid_until < Date.today }

    #A little confusing: If we have a new pricing model, and it's exactly equal to
    # an old one, we want to remove it from both the "to be processed" list (new pricing models)
    # and the "to be disabled" list (replaced pricing models)
    word_document.pricing_models.active.each do |model|
      new_prices.reject! do |m|
        if m == model
          @prices_to_disable.delete_if{|pm| pm == model}
          true
        else
          false
        end
      end
    end

    add_pricing_model_geo_restrictions(new_prices)

    @prices = new_prices
    @prices = word_document.pricing_models.active if @prices.blank?
  end

  #list prices sets a default price if none exists
  #prices= clobbers that default price if it can
  def list_price=(new_list_price)
    @list_price = BigDecimal.new(new_list_price)
    if @list_price > 0
      @prices ||= [model_from_price(OpenStruct.new(:retail_price => new_list_price.to_s, :pricing_model => "Wholesale"), word_document, word_document.word_user.seller)]
    end
    @list_price
  end

  def series=(series_data)
    @series_records = []
    @collection_data = []

    publisher_id = publisher_tools_config.word_user_id

    series_data.each do |series|    # Each series represents a unique collection
      series_records = []
      collection_id = nil
      decoder = ::HTMLEntities.new
      series_title = decoder.decode(decoder.decode(series.title))

      # Add a title series identifier
      title_iden = ::MetadataParser::PublisherTools::Component::SeriesIdentifier.create_custom_iden(series_title)
      series_identifiers = series.identifiers << title_iden

      series_identifiers.each do |series_identifier|    # There could be multiple series identifiers representing one series
        s_record = SeriesIdentifier.find_or_initialize_by_type_code_and_identifier_and_word_user_id(series_identifier.type_code,
                                                                                                    series_identifier.value,
                                                                                                    publisher_id)
        collection_id ||= s_record.document_collection_id

        series_records << s_record
      end

      collection = if collection_id.present?
        DocumentCollection.find(collection_id)
      else
        c = DocumentCollection.new
        c.word_user_id = publisher_tools_config.word_user_id
        c.name = series_title
        c
      end

      # Store all records so they can later be saved
      @collection_data << OpenStruct.new({:collection => collection, :position => series.position, :series_records => series_records})
    end # series.each
  end

  def for_subscription=(for_subscription)
    if publisher_tools_config.word_user.pmp_publisher? && for_subscription == 'N'
      exemption = PmpExemptBook.new
      exemption.word_document_id = self.word_document.id
      exemption.save!
    end
  end

  def publish_date=(date)
    # Used for pricing and 'when to publish' book logic
    @publish_date = parse_date(date)
  end

  def book_publication_date=(date)
    # Priority: YearFirstPublished Onix field, bowker data, PublicationDate Onix field
    @book_publication_date ||= date
  end

  def book_publication_date
    @book_publication_date
  end

  def year_first_published=(year)
    # Priority: YearFirstPublished Onix field, bowker data, PublicationDate Onix field
    @book_publication_date = year
  end

  def year_first_published
    @book_publication_date
  end

  def category=(category_name)
    #We no longer import 'scribd categories' from spreadsheets.
  end

  def authors=(authors)
    my_authors = bowker.authors.try(:values)
    my_authors = authors if my_authors.blank?

    @authors ||= []
    @authorships ||= []
    author_names = {}

    my_authors.compact.each do |author|
      next if author_names[author.name] #Publishers give us the same author multiple times, for the same book. I don't know why.
      author_names[author.name] = true

      scribd_author = ::Author.find_by_bowker_id(author.bowker_id) if author.bowker_id
      scribd_author ||= ::Author.find_or_initialize_by_author_name_and_publisher_id(author.name, word_document.word_user_id, :publisher_tools)
      scribd_author.initialize_word_user(author)

      if author.bowker_id.present? && scribd_author.bowker_id.blank?
        scribd_author.bowker_id = author.bowker_id
      end

      @authorships.push(scribd_author.attach_to_document(word_document, author.sequence))
      @authors.push(scribd_author)
    end
    clean_authors
  end

  def full_title=(title)
    word_document.title = title
  end

  def full_title
    word_document.title
  end

  def bisac_categories=(categories)
    bowker_categories = bowker.bisac_categories
    @bisac_categories ||= []

    categories += bowker_categories
    categories.uniq!

    categories.each do |cat|
      bisac_category = BisacCategory.on_slow_slave.find_by_code(cat)
      next if bisac_category.blank?
      membership = BisacCategoryMembership.find_or_initialize_by_word_document_id_and_bisac_category_id(word_document.id, bisac_category.id)
      @bisac_categories.push(membership)
    end
    return @bisac_categories
  end

  def imprints=(imprints)
    tmp = []
    bowker_imprint = bowker.imprint
    @imprints ||= []
    tmp = imprints
    tmp.push(bowker_imprint) if bowker_imprint.present?
    tmp = tmp.flatten.compact

    tmp = tmp.uniq_by { |imp| imp.name }

    tmp.each do |imp|
      imprint = Imprint.on_master.find_or_create_by_name_and_publisher_id(imp.name, word_document.word_user_id)
      membership = ImprintMembership.on_master.find_or_initialize_by_imprint_id_and_word_document_id(imprint.id, word_document.id)
      @imprints.push(membership)
    end
    return @imprints
  end

  def tags=(new_tags)
    @tags = new_tags
    with_retries { word_document.set_tags_from_csv(new_tags) }
    @tags
  end

  def download_and_drm=(new_download_and_drm)
    set_download_and_drm(new_download_and_drm)
  end

  def page_count=(page_count)
    unless page_count.blank? or page_count == "0"
      book.page_count = page_count.to_i
      word_document.page_count = page_count.to_i if word_document.word_upload.extension == "epub"
    end
  end

  def language=(language)
    book.language = language unless language.blank?
  end

  def audience=(audience)
    book.audience = audience unless audience.age_low.blank?
  end

  def add_pricing_model_geo_restrictions(new_prices)
    #Go through each new_prices, find any restricted countries.
    geo_restricts = new_prices.collect do |price|
      if price.excluded_countries.present?
        restrict = OpenStruct.new(:countries => price.excluded_countries, :banned? => true)
        restrict.class_eval <<-RUBY
          def for_world?(country)
            false
          end
        RUBY
        restrict
      end
    end.compact

    #Go through new prices again, removing restricted_countries that
    # have a price valid for them
    geo_restricts.delete_if do |geo_restrict|
      result = false
      new_prices.each do |price|
        result = true if geo_restrict.countries.include? price.country
      end
      result
    end

    #create remaining geo restrictions.
    self.sales_rights = geo_restricts if geo_restricts.present?
  end

  #There's more to sales rights than just using them now
  def sales_rights=(new_rights)
    @sales_rights ||= []
    allowed = []
    denied = []
    existing_restricts = word_document.geo_restrictions.to_a
    world = existing_restricts.find{|t| t.is_world? }
    new_rights.each do |right|
      right.countries.each do |country|
        restrict_country = right.for_world?(country) ? nil : country
        restrict = existing_restricts.find{|t| t.country.to_s.downcase == restrict_country.to_s.downcase}
        restrict ||= ::Store::GeoRestriction.new(:country => restrict_country)
        restrict.sale_restricted = right.banned?
        restrict.item = word_document
        world = restrict if restrict.is_world?
        if right.banned?
          denied.push(restrict)
        else
          allowed.push(restrict)
        end
      end
    end
    @sales_rights = clean_sales_rights!(allowed, denied, world, @sales_rights).flatten
  end

  #allowed and denied are modified by this method.
  def clean_sales_rights!(allowed, denied, world, existing=[])
    existing.each do |right|
      if right.sale_restricted?
        denied.push(right)
      else
        allowed.push(right)
      end
    end

    if world.blank?
      world = create_world_right(allowed, denied)
      if world
        if world.sale_restricted?
          denied = nil
        else
          allowed = nil
        end
      end
    end
    [world, allowed, denied].flatten.compact
  end

  def create_world_right(allowed, denied)
    restrict = ::Store::GeoRestriction.new(:country => nil, :sale_restricted => false)
    restrict.item = word_document
    restrict.country = nil
    if allowed.count > 100 && denied.count == 0    #world-allow
      restrict.sale_restricted = false
    elsif denied.count > 100 && allowed.count == 0 #Error
      self.errors.add(:georestriction, "More than 100 denies specified with no allows. Please add an allow record.")
    elsif allowed.count > 0 && denied.count == 0   #world-deny
      restrict.sale_restricted = true
    elsif denied.count > 0 && allowed.count == 0   #world-allow
      restrict.sale_restricted = false
    elsif allowed.count > 0 && denied.count > 0 #world-deny
      restrict.sale_restricted = true
    else
      return nil
    end
    return restrict
  end


  def sort_pricing_models(models)
    models.sort{|m1, m2| m1.valid_until <=> m2.valid_until}
  end

  def model_from_price(price, word_document, seller)
    models = []
    countries = Array(price.countries)
    countries = [nil] if countries.blank?
    countries.each do |country|
      pm = "Payments::PricingModels::#{price.pricing_model}Model".constantize.new
      pm.valid_from = price.valid_from
      pm.valid_until = price.valid_until
      pm.country = country
      pm.model_price = price.retail_price * 100
      pm.retail_price = price.retail_price * 100
      pm.seller_share_percent = seller.send("#{price.pricing_model.split("::")[-1].downcase}_share_percent")
      pm.seller = seller
      pm.sellable = word_document
      pm.active = true
      pm.excluded_countries = price.excluded_countries.split(" ") if price.excluded_countries.present?
      models.push(pm)
    end
    models
  end

  def clean_prices(new_prices)
    return if new_prices.blank?
    #If we end up with zero after this next step, we had no USD prices, so error out.
    new_prices.delete_if{|p| (p.currency.present? && p.currency != "USD") || !publisher_tools_config.uses_pricing_model?(p.pricing_model.split("::")[-1].downcase)}
    raise "We have no USD Prices, but this is not a free doc" if new_prices.count == 0
    return new_prices
  end

  def clean_authors
    @authors = @authors.uniq_by{|author| author.author_name}
    @authorships = @authorships.uniq_by{|auth| auth.word_user.name}
  end

  def set_library_thing_information
    @library_thing_stats = self.library_thing.library_thing_stats
    @library_thing_reviews = self.library_thing.library_thing_reviews
    @library_thing_recommendations = self.library_thing.library_thing_recommendations
  end

private
  def add_bowker_data(authors)
    authors.each do |author|
      bowker.add_bowker_data(author)
    end
  end
end
