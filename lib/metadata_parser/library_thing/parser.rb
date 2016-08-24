# Abstract parser for all LibraryThing data. The main thing we have to do for each one is to overwrite parse_row
module MetadataParser
  class LibraryThing::Parser < ParserBase
    filename_pattern /\.(?:xml)\Z/i

    def import_objects &block
      begin
        reader = XmlIncrementalReader.new(file, "work")
        reader.each_entity_string do |entity|
          yield parse_row(entity)
        end
      rescue => e
        log_error("Parsing exception #{e} \n #{e.backtrace.join(", \n ")}")
      end
    end

    def log_error(message, level="error")
      errors.add(:base, message) if level == "error"
    end

    private

    def parse_row(row)
      raise "Must overwrite me with the proper row component"
    end
  end
end
