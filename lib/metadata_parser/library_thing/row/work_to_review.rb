require "nokogiri"
module MetadataParser
  class LibraryThing::Row::WorkToReview < Row::RowBase
    attr_accessor :raw_data, :product

    add_fields [
      :workcode,
      :isbn,
      :userid,
      :restricted,
      :stars,
      :text
    ]
    attr_accessor *accessors

    def initialize(product_string)
      self.raw_data = product_string
      self.product = Nokogiri::XML.fragment(product_string)
    end

    def workcode
      self.product.css("workcode").text
    end

    def isbn
      isbn = self.product.css("ISBN").text
      if isbn.length == 10
        isbn = DocumentIdentifier.isbn10_to_13(isbn)
      end
      return isbn
    end

    def stars
      self.product.css("stars").text
    end

    # Review text must be sanitized in case there are newline characters.
    def review_text
      self.product.css("text").text.gsub("\n","").gsub("|","")
    end

    def review_id
      self.product.css("review").first["id"]
    end

    def user_id
      self.product.css("userid").text
    end

    def written_stamp
      self.product.css("written_stamp").text
    end

  end
end
