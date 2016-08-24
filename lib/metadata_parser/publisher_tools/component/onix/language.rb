module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Language
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

          add_onix_code :language_role, "b253", "LanguageRole"
          add_onix_code :language_code, "b252", "LanguageCode"

          def language
            if language_role == '01'  # if language of text
              language_code
            end
          end

        end #Language
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
