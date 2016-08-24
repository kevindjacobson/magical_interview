module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Audience < ::MetadataParser::PublisherTools::Component::Audience
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          # PR.14.8 Audience  range precision codes
          RANGE_PRECISION = { '01' => :exact, '03' => :from, '04' => :to }

          # PR.14.7 Audience range qualifier codes
          US_GRADE_RANGE_CODE = '11'
          INTEREST_AGE_CODE = '17'
          READING_AGE_CODE = '18'

          MIN_AGE = 1
          MAX_AGE = 120

          add_onix_code :range_code, "b074", "AudienceRangeQualifier"
          add_onix_code :range_precision, "b075", "AudienceRangePrecision", :array
          add_onix_code :range_value, "b076", "AudienceRangeValue", :array

          def self.klass
            class << self
              self
            end
          end

          def self.create_from_method(meth)
            klass.instance_eval do
              define_method(meth) do |param|
                return nil if param.blank?
                aud = self.new
                aud.send("set_range_from_#{meth.split("_").last}", param)
              end
            end
          end

          ['create_from_range', 'create_from_codes', 'create_from_grades', 'create_from_age'].each do |m| 
            create_from_method(m)
          end

          def set_range_from_range(range)
            if range.present?
              range = range.first
              val = range.send(:get_range_from_fields)
              case range.range_code
              when US_GRADE_RANGE_CODE
                self.set_range_from_grades(val)
              when INTEREST_AGE_CODE, READING_AGE_CODE
                self.age_low, self.age_high = val
                self.age_high ||= self.age_low
              end
              self
            else
              nil
            end
          end   #Return nil if bad data 
      
          def set_range_from_codes(codes)
            if codes.present?
              ranges = []
              codes.each do |code| 
                ranges.concat(get_age_range_from_code(code.to_i))
              end
              self.age_low, self.age_high = ranges.min, ranges.max
              self.age_high ||= self.age_low
              self
            else
              nil
            end
          end
      
          def set_range_from_grades(grades)
            if grades
              # Assumes US grade levels
              grades = parse_audience_range grades if grades.is_a? String   # transform string into array of vals
              ages = grades.map { |grade| self.grade_to_age(grade) }

              set_from_age_values(ages)

              self
            else
              nil
            end
          end

          def set_range_from_age(age)
            if age
              ages = parse_audience_range(age)

              set_from_age_values(ages)

              self.age_low, self.age_high = self.age_low.to_i, self.age_high.to_i
              self
            else
              nil
            end
          end

      
          def grade_to_age(grade)
            # Assumes US grade levels
            case grade
            when 'P', 'pre-school'
              return 4
            when 'K', 'kindergarten'
              return 5
            when 'from', 'to'
              return grade   # allow special tokens to pass through
            else
              return grade.to_i + 5 if (1..12).include?(grade.to_i)
            end
            0
          end
      
        private

          def set_from_age_values(ages)
            case ages.first
            when 'from', 'to'
              handle_from_to(ages)
            else
              self.age_low, self.age_high = ages
            end
            self.age_high ||= self.age_low
          end
          
          def handle_from_to(range)
            # expects an array in the form of ['from', n1, 'to', n2] || ['from', n] || ['to', n]
            case range.first
            when 'from'
              if range.length == 2    # from n
                self.age_low = range[1]
                self.age_high = MAX_AGE
              elsif range.length == 3 # from n1 to n2
                self.age_low = range[1]
                self.age_high = range[2]
              end
            when 'to'
              self.age_low = MIN_AGE
              self.age_high = range[1]
            end
          end
      
          def get_range_from_fields
            # returns the audience range from the range precision and range value fields as an array
            first_field, second_field = range_precision
      
            case RANGE_PRECISION[first_field]
            when :exact, :from
              low, high = range_value
            when :to
              high, low = range_value
            end
          end
      
          def parse_audience_range(range)
            # possible forms:
            # from n1 to n2
            # from n
            # to n
            # n
            # n is a number (representing grade or age), or 'pre-school', or 'P', or 'kindergarten', or K (i hate you onix)
            range.scan /\d+|kindergarten|K|pre-school|P|^from|^to/
          end
        end
      end
    end
  end
end