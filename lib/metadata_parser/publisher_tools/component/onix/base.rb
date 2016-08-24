module MetadataParser
  module PublisherTools
    module Component
      module Onix
        module Base
          extend ActiveSupport::Concern

          included do
            # only used for errors RAILS 3
            include ACTIVE_MODEL_VALIDATION_CONST
          end

          module ClassMethods
            def human_attribute_name(*args); return *args end
          end

          # used in ActiveRecord validations
          def save; end; def save!; end

          def initialize(xml_fragment=nil)
            if xml_fragment
              xml_fragment.children.each do |node|
                field = self.class.lookup_by_code(node.name)
                next if field.nil?
                
                case field[:type]
                when :array
                  accumulate_values(field[:name], node.text)
                when :int
                 self.send("#{field[:name]}=", node.text.to_i) 
                when :component 
                  accumulate_values(field[:name], parse_component(field, node))  
                else
                  self.send("#{field[:name]}=", node.text)
                end

              end
            end
          end

          def add_error(field, message)
            self.errors.add(field, message)
          end

          def accumulate_values(field, new_val)
            current_val = self.send(field) 

            current_val ||= Array.new

            current_val << new_val if new_val.present?
            self.send("#{field}=", current_val)
          end

          def parse_component(field, data)
            component = field[:component]
            val = component.new(data)
            self.errors.add(field[:name], val.errors.map{|x,y| y }.join(", ")) if val.errors.messages.present?
            return nil if errors.any?
            return val
          end

          def to_json
            # Dump a representation of the component's data as json
            data = []
            instance_variables.each do |var|
              data << [var, self.instance_variable_get(var)]
              data.sort! {|a, b| a[0] <=> b[0]}
            end
            data.to_json
          end

        end #Base
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
