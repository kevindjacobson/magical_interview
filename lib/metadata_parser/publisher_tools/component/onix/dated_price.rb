module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class DatedPrice < PublisherTools::Component::DatedPrice
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          # j152 => ISO currency, USD, CAD, etc
          # j151 => Price amount
          # j148 => price type code list 58
          #         01  (Wholesale)RRP excluding tax   RRP excluding any sales tax or value-added tax
          #         41  (Agency)Publishers retail price excluding tax   For a product supplied on agency terms, the retail price
          #               set by the publisher, excluding any sales tax or value-added tax
          # j161 => effective valid price date
          # j162 => effective until
          # b251 => The country code this price is valid in.

          add_onix_code :countries, 'b251', 'CountryCode', :array
          add_onix_code :currency, 'j152', 'CurrencyCode'
          add_onix_code :valid_from, 'j161', 'PriceEffectiveFrom'
          add_onix_code :valid_until, 'j162', 'PriceEffectiveUntil'
          add_onix_code :retail_price, 'j151', 'PriceAmount'
          add_onix_code :pricing_model, 'j148', 'PriceTypeCode'
          add_onix_code :price_qualifier, 'j261', 'PriceQualifier'

          #We should technically parse this out, but harpercollins is the only publisher who uses this, and
          # they always set "world".
          #add_onix_code :included_countries, "j303", "Territory"
          add_onix_code :excluded_countries, "j304", "CountryExcluded"

          def retail_price=(val)
            @retail_price = BigDecimal.new(val.to_s)
          end

          def valid_until=(val)
            @valid_until = MetadataParser::ParserBase.parse_date(val)
          end

          def valid_from=(val)
            @valid_from = MetadataParser::ParserBase.parse_date(val)
          end

          def [](val)
            return self.send(val)
          end

          def pricing_model
            case @pricing_model.to_i
            when 41, 42
              return "Agency"
            when 1
              return "Wholesale"
            else
              return "Unknown"
            end
          end

          def has_us_retail_price?
            return self.retail_price.present? && (price_qualifier.nil? || price_qualifier == '05') &&
                   currency == 'USD'
          end
        end #DatedPrice
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
