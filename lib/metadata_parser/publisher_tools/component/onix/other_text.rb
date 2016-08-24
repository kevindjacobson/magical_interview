module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class OtherText
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :description_entity, "d104", "Text"
          add_onix_code :text_type_code, "d102", "TextTypeCode"

          def description
            if text_type_code == '01'
              description_entity
            end
          end
        end #OtherText
      end  #Onix
    end  #Component
  end  #PublisherTools
end  #MetadataParser