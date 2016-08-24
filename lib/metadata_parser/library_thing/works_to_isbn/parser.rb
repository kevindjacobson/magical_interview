module MetadataParser
  class LibraryThing::WorksToIsbn::Parser < LibraryThing::Parser
    def parse_row(row)
      LibraryThing::Row::WorkToIsbn.new(row)
    end
  end
end
