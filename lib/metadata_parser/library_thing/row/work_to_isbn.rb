require "nokogiri"
module MetadataParser
  class LibraryThing::Row::WorkToIsbn < Row::RowBase
    attr_accessor :raw_data, :product

    add_fields [
      :isbns
    ]
    attr_accessor *accessors

    def workcode
      work_node = self.product.xpath("work").first
      return "" if work_node.nil?

      work_node["workcode"]
    end

    def copies
      work_node = self.product.xpath("work").first
      return "" if work_node.nil?

      work_node["copies"]
    end

    def popularity
      work_node = self.product.xpath("work").first
      return "" if work_node.nil?

      work_node["popularity"]
    end

    def count
      isbn_node = self.product.css("isbn").first
      return "" if isbn_node.nil?

      isbn_node["count"]
    end

    # The ISBNs aren't normalized, so we need to convert them to isbn13s if necessary.
    def isbn
      isbn_node = self.product.css("isbn").first
      return "" if isbn_node.nil?

      isbn = isbn_node.text
      if isbn.length == 10
        isbn = DocumentIdentifier.isbn10_to_13(isbn)
      end
      return isbn
    end


    def initialize(product_string)
      self.raw_data = product_string
      self.product = Nokogiri::XML.fragment(product_string)
    end
  end
end
