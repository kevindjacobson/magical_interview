# Abstract class for rows

module MetadataParser
  module Row
    class RowBase
      include ActiveSupport::Memoizable

      # used in ActiveRecord validations
      def save; end; def save!; end
      def self.human_attribute_name(*args); return *args end
      include ACTIVE_MODEL_VALIDATION_CONST

      # Example of a hash field: { :pricing => [:prices, :list_price] }
      # Field is pricing but may use both list_prices and/or prices
      def self.add_fields(added)
        hsh = {}
        added.each do |field|
          if field.is_a?(Hash)
            field = field.to_a
            hsh[field.first.first] = Array(field.first.last)
          else
            hsh[field] = Array(field)
          end
        end
        @fields = hsh
      end

      def self.fields
        @fields
      end

      def self.field_to_accessors(field)
        self.fields[field]
      end

      def self.accessors
        @accessors ||= fields.collect do |arr|
          arr.last
        end.flatten
      end

      def to_json
        hash = self.class.accessors.inject({}) do |accum, key|
          value = send key
          accum[key] = value if value.present?
          accum
        end

        # Print prices as strings so they don't get converted into
        # fixnums
        if hash[:prices]
          hash[:prices].each do |obj|
            obj[:price] = obj[:price].to_s
          end
        end

        hash.to_json
      end

      def self.new_from_json(json)
        new_from_hash JSON.parse(json).with_indifferent_access
      end

      def self.new_from_hash(hash)
        obj = new
        self.class.accessors.each do |key|
          obj.send("#{key}=", hash[key])
        end
        return obj
      end

      def self.schema_from_version(version)
        return nil # Override me if you have schemas for your subclass.
      end

      def valid?
        validate!
        errors.blank?
      end

      def validate!
        true # Override me if you want validations to run in a subclass.
      end
    end #RowBase
  end #Row
end #MetadataParser
