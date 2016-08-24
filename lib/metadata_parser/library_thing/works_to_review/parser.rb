module MetadataParser
  class LibraryThing::WorksToReview::Parser < LibraryThing::Parser
    def import_objects &block
      begin
        reader = XmlIncrementalReader.new(file, "review")
        reader.each_entity_string do |entity|
          yield parse_row(entity)
        end
      rescue => e
        log_error("Parsing exception #{e} \n #{e.backtrace.join(", \n ")}")
      end
    end
    def parse_row(row)
      LibraryThing::Row::WorkToReview.new(row)
    end
  end
end
