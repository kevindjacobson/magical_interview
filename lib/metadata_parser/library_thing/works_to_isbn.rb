module MetadataParser
  class LibraryThing::WorksToIsbn < ParserBase

    # Breaks a file apart into objects.
    # Each object corresponds to a LibraryThing workcode -> ISBN mapping.
    # We write what we get into a delimited text file so we can load it into Hive and Hbase.

    def self.import_objects(file)
      delimited_file = File.new("works_to_isbn", "w")
      begin
        parser = LibraryThing::WorksToIsbn::Parser.new(file)

        parser.import_objects do |parsed|
          delimited_file.write("#{parsed.workcode}|#{parsed.copies}|#{parsed.popularity}|#{parsed.isbn}|#{parsed.count}\n")
        end
      ensure
        delimited_file.close()
      end
    end
  end
end
