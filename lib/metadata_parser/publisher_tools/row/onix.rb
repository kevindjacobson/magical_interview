require "nokogiri"

module MetadataParser
  module PublisherTools
    module Row
      class Onix < ::MetadataParser::PublisherTools::Row::Base
        extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
        include ActiveSupport::Memoizable
        attr_accessor :raw_data, :publisher_tools_config, :product, :is_reference, :product_component

        ::MetadataParser::PublisherTools::Row::Base.accessors.each do |acc| 
          delegate acc, :to => :@product_component
        end
        delegate :errors, :to => :@product_component

        def initialize(product_string, publisher_tools_config, schema=nil, flex_schema=nil)
          self.publisher_tools_config = publisher_tools_config
          self.raw_data = product_string

          # Set product here to check if it's a reference (longname) or a short name fragment.
          self.product = Nokogiri::XML.fragment(product_string)
          self.is_reference = self.product.xpath("Product").any?

          # Once it is known, reset it to the actual xml fragment (i.e. Product or product)
          self.product = self.is_reference ? self.product.xpath("Product") : self.product.xpath("product")

          # Initialize product component
          self.product_component = ::MetadataParser::PublisherTools::Component::Onix::Product.new(self.product)
        end


        def valid?
          # These getters set their own errors
          errors.clear
          publish_date
          prices
          deleting
          super
        end

        private
        def add_error(field, msg)
          if field
            errors.add field, msg
          else
            errors.add :base, msg
          end
        end
      end # Onix
    end # Row
  end # PublisherTools
end #MetadataParser
