# Usage example:
# MetadataParser::LibraryThing::WorksToRecommendation.import_objects(File.new("recommendations.xml"))
module MetadataParser
  class LibraryThing::WorksToRecommendation < ParserBase
    def self.import_objects(file)
      puts "Generating a delimited text file..."
      delimited_file = File.new("works_to_recommendation", "w")
      begin 
        parser = LibraryThing::WorksToRecommendation::Parser.new(file)

        parser.import_objects do |parsed|
          delimited_file.write("#{parsed.workcode}|#{parsed.recommendations}\n")
        end
        puts "Completed successfully!"
      ensure
        delimited_file.close()
      end
    end
  end
end
