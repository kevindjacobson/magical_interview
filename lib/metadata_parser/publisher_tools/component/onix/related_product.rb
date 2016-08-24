module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class RelatedProduct
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

          add_onix_code :related_isbn, "productidentifier", "ProductIdentifier", :component => ::MetadataParser::PublisherTools::Component::Onix::Isbn
          add_onix_code :relation_code, "h208", "RelationCode"

          #Returns an array of all isbns
          def isbn
            return nil unless valid_type?
            return related_isbn.collect &:isbn
          end

          def valid_type?
            ['1', '2', '3', '5', '6', '13', '14', '15',
             '16', '17', '18', '19', '20', '21', '24', 
             '25', '27', '28', '29'].include? self.relation_code
          end
        end #RelatedProduct
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
