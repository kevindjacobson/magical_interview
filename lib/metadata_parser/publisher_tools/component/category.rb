module MetadataParser
  class PublisherTools::Component::Category
    attr_accessor(:code)
    def is_bisac?
      return true
    end
  end
end
