module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Category
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

          add_onix_code :code_type, "b067", "SubjectSchemeIdentifier"
          add_onix_code :code, "b069", "SubjectCode"

          def is_bisac?
            return self.code_type == "10"
          end
        end #Category
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
