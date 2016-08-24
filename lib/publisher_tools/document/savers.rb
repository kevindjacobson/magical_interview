class PublisherTools::Document
  include LibraryThingSaver

   def save
    #Can't save if we didn't parse...
    return false unless parsed
    return delete! if deleting?
    
    savers.each do |saver|
      self.send(saver)
    end

    word_document.save!
    metadata.save!
    book.save! if @book # Only save if we have Book information as set in PublisherTools::Document


    word_document.controlled_document.save! if word_document.controlled_document
    return true
  end
  alias_method :save!, :save

  def save_alternate_isbns
    @document_identifiers.each &:save! if @document_identifiers.present?
  end

  def save_authors
    Author.transaction do 
      #This is split out to save the word user first because in some rare cases the rails magic wasn't working.
      (authors || []).compact.each do |author| 
        author.word_user.save!
        author.save!
      end

      (@authorships || []).compact.each do |auth|
        auth.save!
      end
    end
  end

  def save_bisac_categories
    (bisac_categories || []).compact.each do |cat_membership|
      cat_membership.save! if cat_membership.new_record?
    end
  end

  def save_imprints
    @imprints.each do |imprint_membership|
      #Don't ask me why, but we're getting duplicate imprints sometimes, so 
      # we'll make sure it doesn't exist before we try to save it.
      if ImprintMembership.on_master.find_by_word_document_id_and_imprint_id(imprint_membership.word_document_id, imprint_membership.imprint_id).blank?
        imprint_membership.save
      end
    end if @imprints.present?
  end

  def save_pricing
    save_pricing_models
    save_future_pricing
  end

  def save_pricing_models
    if paid?
      Payments::PricingModels::PricingModel.transaction do 
        prices_to_disable.each &:deactivate
        prices_to_disable.each &:save!
        prices.each &:save!
        paid_document.save!
      end
    end
  end

  def save_future_pricing
    #Find today's price for this document...
    now = Time.now
    today = Date.today

    #Only queue a job if we're supposed to publish this document.
    return if publisher_tools_config.always_private?

    prices.each do |pricing_model|
      next if pricing_model.valid_until < today

      #This bit is since we don't care about prices that were valid in the past.
      new_time = pricing_model.valid_from.to_time
      new_time = now if new_time < now
      #And don't bother with any prices valid before we're supposed to publish it.
      new_time = publish_date if publish_date && new_time < publish_date

      #Set up queued jobs to change the displayed retail price + publish when the price changes.
      publish_on(new_time)
    end
  end

  def publish_on(time)
    return if publisher_tools_config.always_private?
    Queues::PublisherTools::PublisherToolsEventQueue.put(word_document, publisher_tools_config, import_record, time, :publish)
  end

  def save_sales_rights
    return if sales_rights.nil?
    self.sales_rights.each do |right|
      word_document.geo_restrictions.push(right)
    end
  end

  def save_collections
    (collections || '').split("\n").each do |collection_name| #handles empty string actually...
      conditions = {:word_user_id => word_document.word_user_id, :name => collection_name}
      collection = DocumentCollection.first(:conditions => conditions)
      unless collection
        word_user_id = conditions.delete :word_user_id
        collection = DocumentCollection.new(conditions)
        collection.word_user_id = word_user_id
        collection.description = ''
        collection.save!
      end
      collection.add_document(word_document)
    end
    @collections_saved = true
    save_featured_collection
    save_series
  end

  def save_series
    if @collection_data.present?
      # This is a seperate loop because all collections should successfuly be saved before identifiers are saved and documents added
      @collection_data.each { |item| item.collection.save! }

      @collection_data.each do |item|
        # Set the collection_ids for new collections that didnt have ids in the setter stage 
        item.series_records.each do |series_record| 
          series_record.document_collection_id = item.collection.id
          series_record.save!
        end

        if item.collection.addable_document?(word_document)
          collecting = item.collection.add_document(word_document, item.position)
          collecting.save!
        elsif word_document.gone? || item.collection.has_document?(word_document)
          nil  # if the document was already added, ignore.
        else
          raise "Document not addable because #{item.collection.not_addable_reason(word_document)}"
        end
      end
    end
  end

  def save_featured_collection
    raise 'You must save collections before setting featured collections.' unless @collections_saved

    return unless featured_collection_object
    pro_settings = word_document.publisher_pro_document_setting ||
      word_document.create_publisher_pro_document_setting
    pro_settings.data[:custom_document_collection_id] = featured_collection_object.id
    pro_settings.save!
  end

  def delete!
    word_document.delete!(:force => true)
  end

  #Saves some publishing-related info.
  # This used to save future publication dates, but that's done in
  # the pricing model + book imports now.
  def save_publish_date
    if publisher_tools_config.always_private?
      word_document.private = true
      import_data[:always_private] = true
      return true
    end
  end

  def save_book_publication_date
    book.publication_date = @book_publication_date if @book_publication_date.present?
  end

  def save_year_first_published
    book.publication_date = @book_publication_date if @book_publication_date.present?
  end
end
