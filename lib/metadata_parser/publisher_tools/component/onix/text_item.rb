module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class TextItem
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

          add_onix_code :page_count, "b061", "NumberOfPages"

        end #TextItem
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
