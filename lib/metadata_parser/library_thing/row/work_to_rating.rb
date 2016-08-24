require "nokogiri"
module MetadataParser
  class LibraryThing::Row::WorkToRating < Row::RowBase
    attr_accessor :raw_data, :product

    add_fields [
      :rating
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

    def rating_hash
      ratings = {}
      rating_nodes = self.product.css("rating").each do |node|
        ratings[node.attribute("stars").value] = node.text.to_i
      end

      # The next two are there to make Hive queries simpler.

      total = ratings.values.reduce(0, :+)

      average = (ratings.reduce(0) do |memo, (k, v)|
        memo += k.to_f * v
      end) / total

      ratings[:total] = total
      ratings[:average] = average

      return ratings
    end
  end
end
