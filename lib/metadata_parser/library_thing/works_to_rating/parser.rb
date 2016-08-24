module MetadataParser
  class LibraryThing::WorksToRating::Parser < LibraryThing::Parser
    def parse_row(row)
      LibraryThing::Row::WorkToRating.new(row)
    end
  end
end
