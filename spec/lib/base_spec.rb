require "./spec/spec_helper"
  describe ::MetadataParser::PublisherTools::Row::Base do
    # integration test

  it "accepts a row, schema, and flex schema and can produce a parsed, jsonified version of that data" do
    b = ::MetadataParser::PublisherTools::Row::Base.new
    b.title = "hello"
    b.description = "f"
    b.isbn = ""
    b.category = nil
    b.publish_date = Time.utc(1985, 11, 12)
    b.deleting = false

    row_json = JSON.parse(b.to_json)

    row_json["title"].should == "hello"
    row_json["description"].should == "f"
    row_json["publish_date"].should == "1985-11-12T00:00:00Z"
  end

  it "should provide the correct field and accessor names" do
    expected_fields = [
      "[:alternate_isbns, [:alternate_isbns]]",
      "[:authors, [:authors]]",
      "[:bisac_categories, [:bisac_categories]]",
      "[:book, [:book_publication_date, :year_first_published, :audience, :title, :subtitle]]",
      "[:buy_url, [:buy_url]]",
      "[:category, [:category]]",
      "[:collections, [:collections, :featured_collection, :series]]",
      "[:currency_code, [:currency_code]]",
      "[:deleting, [:deleting]]",
      "[:description, [:description]]",
      "[:download_and_drm, [:download_and_drm]]",
      "[:filename, [:filename]]",
      "[:flex_columns, [:flex_schema, :flex_columns]]",
      "[:for_direct_purchase, [:for_direct_purchase]]",
      "[:for_subscription, [:for_subscription]]",
      "[:full_title, [:full_title]]",
      "[:imprints, [:imprints]]",
      "[:isbn, [:isbn]]",
      "[:language, [:language]]",
      "[:library_thing_information, [:library_thing_information]]",
      "[:page_count, [:page_count]]",
      "[:page_restriction, [:page_restriction_type, :page_restriction_value]]",
      "[:pricing, [:prices, :list_price]]",
      "[:publish_date, [:publish_date]]",
      "[:sales_rights, [:sales_rights]]",
      "[:series, [:series]]",
      "[:tags, [:tags]]"
    ].sort
    ::MetadataParser::PublisherTools::Row::Base.fields.collect(&:inspect).sort.should == expected_fields

    expected_fields = [
      "full_title", "description", "isbn", "imprints", "category", "authors", "publish_date", "deleting",
      "prices", "list_price", "sales_rights", "tags", "filename", "bisac_categories", "buy_url",
      "download_and_drm", "page_restriction_type", "page_restriction_value", "collections", "featured_collection",
      "flex_columns", "flex_schema", "page_count", "language", "library_thing_information", "book_publication_date", "audience", "title",
      "subtitle", "alternate_isbns", "series", "year_first_published", "series", "currency_code", "for_direct_purchase", "for_subscription"
    ].sort
    ::MetadataParser::PublisherTools::Row::Base.accessors.collect(&:to_s).sort.should == expected_fields
  end
end
