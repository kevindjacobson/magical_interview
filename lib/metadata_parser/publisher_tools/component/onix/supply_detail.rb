module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class SupplyDetail 
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :availability_code, "j141", "AvailabilityCode"
          add_onix_code :product_availability, "j396", "ProductAvailability", :int
          add_onix_code :sale_date, "j143", "OnSaleDate"          
          add_onix_code :price_qualifier, "j261", "PriceQualifier"

          add_onix_code :price_component, "price", "Price", :component => ::MetadataParser::PublisherTools::Component::Onix::DatedPrice

          def price_entity
            if price_component.present?
              price_component.select(&:has_us_retail_price?)
            end
          end
        end #SupplyDetail
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
