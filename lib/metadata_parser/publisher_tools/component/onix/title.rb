module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Title
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :title_entity, "b203", "TitleText"
          add_onix_code :subtitle, "b029", "Subtitle"
          add_onix_code :title_type, "b202", "TitleType"

          def title
            if title_type == '01'
              title_entity
            end
          end
        end #Product
      end  #Onix
    end  #Component
  end  #PublisherTools
end  #MetadataParser