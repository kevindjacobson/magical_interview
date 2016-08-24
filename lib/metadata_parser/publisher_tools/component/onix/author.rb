module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Author < PublisherTools::Component::Author
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :name, 'b036', 'PersonName'
          add_onix_code :inverted_name, 'b037', 'PersonNameInverted'
          add_onix_code :sequence, 'b034', 'SequenceNumber', :int
          add_onix_code :role_code, 'b035', 'ContributorRole'
          add_onix_code :affiliation, 'b046', 'Affiliation'
          add_onix_code :description, 'b044', 'BiographicalNote'
          add_onix_code :before_key, 'b039', 'NamesBeforeKey'
          add_onix_code :after_key, 'b041', 'NamesAfterKey'
          add_onix_code :keyname, 'b040', 'KeyNames'
          add_onix_code :corporate_name, 'b047', 'CorporateName'

          def is_author?
            #These come from ONIX list 17
            #A - Authorship codes
            #B - Editor codes
            #C - Compilation codes
            #D - Director codes
            #E - Performer codes (read by, performed by, etc)
            #F - Film/Photographer codes
            #Z - Other codes
            return !(@role_code =~ /(B|D|E)/i)
          end

          def keyname=(oth)
            @key = oth
          end

          def before_key=(oth)
            @before_key = oth
          end

          def after_key=(oth)
            @key = oth
          end

          def inverted_name=(oth)
            @name ||= oth.split(", ").reverse.join(" ")
          end

          def name=(oth)
            @name = oth
          end

          def name
            result = @name
            result ||= [@before_key, @key, @after_key].join(" ") if @key.present?
            if result.blank?
              add_error(:name, "Missing author's name. Keyname parsed as: '#{@before_key}' '#{@key}' '#{@after_key}'")
            end
            return result || corporate_name
          end
        end #Author
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
