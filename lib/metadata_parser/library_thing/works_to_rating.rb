# Usage example:
# MetadataParser::LibraryThing::WorksToRating.import_objects(File.new("small.xml"))

module MetadataParser
  class LibraryThing::WorksToRating < ParserBase

    def self.import_objects(file)
      puts "Generating a delimited text file..."
      delimited_file = File.new("works_to_rating", "w")
      begin
        parser = LibraryThing::WorksToRating::Parser.new(file)

        parser.import_objects do |parsed|
          ratings_hash = parsed.rating_hash
          string = "#{parsed.workcode}|"

          arr = []
          (0.5..5).step(0.5) do |rating|
            if rating % 1 == 0
              rating = rating.to_i
            end
            rating = rating.to_s
            arr.push(ratings_hash[rating])
          end

          delimited_file.write("#{parsed.workcode}|#{arr.join("|")}|#{ratings_hash[:total]}|#{ratings_hash[:average]}\n")
        end
        puts "Completed successfully!"
      ensure
        delimited_file.close()
      end
    end
  end
end
