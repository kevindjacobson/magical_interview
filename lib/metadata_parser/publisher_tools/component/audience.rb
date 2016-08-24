module MetadataParser
  class PublisherTools::Component::Audience
    attr_accessor :age_low, :age_high
    # If exact value is provided rather than range, set both age_low and _high to that value

    # Onix PR.14.1 Audience code list
    GENERAL_TRADE = 1
    CHILDREN_JUVENILE = 2
    YOUNG_ADULT = 3
    ELEMANTARY_HIGH_SCHOOL = 4
    COLLEGE_HIGHER_EDUCATION = 5
    PROFESSIONAL_SCHOLARLY = 6

    def set_from_code(code)
      range = get_age_range_from_code(code)

      if range.present?
        self.age_low, self.age_high = range 
        return self
      else
        nil
      end
    end

    def get_age_range_from_code(code)
      # combines bowker and onix audience codes
      case code
      when 'j', 'S', CHILDREN_JUVENILE, ELEMANTARY_HIGH_SCHOOL
        [3,17]
      when 'Y', YOUNG_ADULT 
        [20,40]
      when GENERAL_TRADE, PROFESSIONAL_SCHOLARLY
        [25, 80]
      when 'C', COLLEGE_HIGHER_EDUCATION
        [18, 25]
      else
        []
      end
    end
  end
end