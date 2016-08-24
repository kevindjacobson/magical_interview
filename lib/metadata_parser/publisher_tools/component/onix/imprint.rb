module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Imprint < PublisherTools::Component::Author
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :imprint_name, 'b079', 'ImprintName'
          add_onix_code :publisher_name, 'b081', "PublisherName"

          def name
            return @name ||= (imprint_name || publisher_name)
          end
        end # Author
      end # Onix
    end # Component
  end # PublisherTools
end # MetadataParser
