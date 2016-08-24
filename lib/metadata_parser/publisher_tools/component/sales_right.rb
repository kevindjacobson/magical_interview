module MetadataParser
  class PublisherTools::Component::SalesRight
    attr_accessor :type, :countries

    def initialize(type, countries)
      @type = type
      @countries = countries
    end

    def allowed?
      @type == "allowed"
    end

    def banned?
      !allowed?
    end

    def for_world?(country)
      # Currently this component does not support worldwide sales rights.
      false
    end
  end
end