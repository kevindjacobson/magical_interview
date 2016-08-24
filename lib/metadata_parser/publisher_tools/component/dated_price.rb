module MetadataParser
  class PublisherTools::Component::DatedPrice
    attr_accessor(:currency, :retail_price, :pricing_model, :countries, :valid_from, :valid_until, :excluded_countries)

    def initialize(hsh)
      self.currency = hsh[:currency] || "USD"
      self.retail_price = BigDecimal.new(hsh[:price].to_s)
      self.pricing_model = hsh[:pricing_model] || "Scribd"
      self.countries = [hsh[:country] || nil]
    end

    def pricing_model
      return "Wholesale"
    end
  end
end
