module MetadataParser
  class PublisherTools::Component::SeriesIdentifier
    attr_accessor :type_code, :value

    def self.create_custom_iden(value)
      iden = new
      iden.make_custom!
      iden.value = value
      iden
    end

    def make_custom!
      self.type_code = 0
    end
  end
end