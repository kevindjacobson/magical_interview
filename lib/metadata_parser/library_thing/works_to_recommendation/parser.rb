module MetadataParser
  class LibraryThing::WorksToRecommendation::Parser < LibraryThing::Parser
    def parse_row(row)
      LibraryThing::Row::WorkToRecommendation.new(row)
    end
  end
end
