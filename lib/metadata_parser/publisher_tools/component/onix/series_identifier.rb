module MetadataParser
  class PublisherTools::Component::Onix::SeriesIdentifier < PublisherTools::Component::SeriesIdentifier

    include ::MetadataParser::PublisherTools::Component::Onix::Base
    extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

    add_onix_code :type_code, "b273", "SeriesIDType", :int
    add_onix_code :value, "b244", "IDValue"


    def self.create_from_issn(issn)
      iden = new
      iden.make_issn!
      iden.value = issn
      iden
    end

    def make_issn!
      self.type_code = 2
    end
  end
end