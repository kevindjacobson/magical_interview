class PublisherTools::HbaseIsbn < PublisherTools::HbaseDocument

  def initialize(isbn)
    if isbn
      self.raw_data = get_data_from_hbase("bowker_alternate_isbns", isbn)
    else
      self.raw_data = OpenStruct.new({})
    end
  end
end
