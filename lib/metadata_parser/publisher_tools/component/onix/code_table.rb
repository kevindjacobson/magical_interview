module MetadataParser
  module PublisherTools
    module Component
      module Onix
        module CodeTables

          def add_onix_code(us, short, reference, field_type=nil)
            @onix_to_us ||= {}
            @us_to_onix ||= {}

            field_data = {:name => us, :type => field_type}
            if field_type.is_a?(Hash) and field_type.has_key?(:component)
              field_data[:type] = :component
              field_data[:component] = field_type[:component]
            end

            @onix_to_us[short] = field_data
            @onix_to_us[reference] = field_data
            @us_to_onix[us] = {:short => short, :reference => reference}

            attr_accessor(us)
          end

          def lookup_by_code(code)
            @onix_to_us[code]
          end

          def lookup_by_field(field, field_type)
            @us_to_onix[field][field_type]
          end

        end #CodeTable
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
