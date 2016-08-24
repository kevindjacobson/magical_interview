# Usage example
# MetadataParser::LibraryThing::WorksToReview.import_objects(File.new("reviews.xml"))

module MetadataParser
  class LibraryThing::WorksToReview < ParserBase
    def self.import_objects(file)
      puts "Generating a delimited text file..."
      delimited_file = File.new("works_to_review", "w")
      begin
        parser = LibraryThing::WorksToReview::Parser.new(file)

        parser.import_objects do |parsed|
          delimited_file.write("#{parsed.workcode}|#{parsed.review_id}|#{parsed.isbn}|#{parsed.stars}|#{parsed.review_text}|#{parsed.user_id}|#{parsed.written_stamp}\n")
        end
        puts "Completed successfully!"
      ensure
        delimited_file.close()
      end
    end
  end
end
