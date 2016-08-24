require "nokogiri"
module MetadataParser
  class LibraryThing::Row::WorkToRecommendation < Row::RowBase
    attr_accessor :raw_data, :product

    add_fields [
      :recommendedwork
    ]
    attr_accessor *accessors

    def initialize(product_string)
      self.raw_data = product_string
      self.product = Nokogiri::XML.fragment(product_string)
    end

    def workcode
      work_node = self.product.xpath("work").first
      return "" if work_node.nil?
      work_node["workcode"]
    end

    def recommendations
      recs = []
      recommended_works = self.product.css("recommendedwork").each do |node|
        recs.push(node.text)
      end
      return recs.join(",")
    end
  end
end
