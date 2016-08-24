module MetadataParser
  class PublisherTools::Component::Onix::SalesRight
    # Returns a data structure with two fields.
    #   region: two character country code or "world"
    #   type: either "allowed" or "banned"

    include ::MetadataParser::PublisherTools::Component::Onix::Base
    extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
    add_onix_code :countries, "b090", "RightsCountry"
    add_onix_code :territories, "b388", "RightsTerritory"
    add_onix_code :type, "b089", "SalesRightsType"

    # Vals:
    #   0 - Unknown
    #   1 - Exclusive rights
    #   2 - Non-exclusive
    #   7,8 - Same as 1,2 but Onix 3
    SALES_ALLOWED = [1, 2, 7, 8]

    def countries=(val)
      @countries ||= []
      val.to_s.split(" ").each do |country|
        if country.length > 2
          if self.class.for_world?(country)
            @countries.push("world")
          else
            add_error(:countries, "Unknown country code '#{country}' (must be 2 characters or world)")
          end
        else
          @countries.push(country)
        end
      end
    end

    def territories=(val)
      self.countries = val
    end

    def type=(val)
      if SALES_ALLOWED.include?(val.to_i)
        @type = "allowed"
      else
        @type = "banned"
      end
    end

    def allowed?
      !banned?
    end

    def banned?
      type == "banned"
    end

    def self.for_world?(country)
      country.blank? || country =~ /world/i || country =~ /row/i
    end

    def for_world?(country)
      return self.class.for_world?(country)
    end
  end
end
