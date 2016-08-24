module MetadataParser
  module PublisherTools
    class ParserHandler
      extend ParserHelpers
      # This breaks a file apart into objects and then creates an import record for each one.
      # The import records store the raw data.
      def self.add_products_to_queue(file_path, publisher_tools_config)
        file = File.open(file_path, 'r')
        import_data = import_objects(file, publisher_tools_config)

        import_data.each do |product|
          #We think we've successfully parsed the metadata at this point. 
          # We might be wrong (and so we'll set errors later), but at least here
          # it all looks good.
          if product.changed?
            product.set_field_waiting(:metadata_status) 
            product.save 
          end
        end
        return true
      end

      def self.import_objects(file, config = {})
        my_parser = detect_parser(file).try(:new, file, config)
        raise "Unparsable File -- '#{file.path}' -- Unknown Extension" if my_parser.nil?

        import_records = []
        my_parser.import_objects do |parsed|
          begin
            import_record = ::PublisherTools::PublisherToolsImport.find_or_initialize_import_record(parsed.filename, config)
            import_record.metadata_version = my_parser.schema_version.to_s
            import_record.metadata_parser = parsed.class.to_s
            import_record.metadata = parsed.raw_data
            import_record.flex_columns = parsed.flex_schema
            import_record.document_title = parsed.title
            import_record.set_import_date!
            search_by = config.find_by_isbn? ? parsed.isbn : parsed.filename
            next if search_by.blank?

            doc = ::PublisherTools::Document.sort_docs(::PublisherTools::Document.find_document(:publisher_config => import_record.publisher_tools_config,
                                                                    :search_by => search_by)).first
            if doc
              import_record.word_document = doc
              # It was already on Scribd.
              import_record.set_field_success(:document_status)
            end
            import_records << import_record
          rescue ::PublisherTools::Error::AmbiguousDocument => e
            import_record.add_exception(e)
            import_record.set_field_error(:metadata_status)
          ensure
            set_import_filename(import_record, parsed, config)
            import_record.save!
            import_records << import_record
          end
        end
        return import_records
      end

      def self.set_import_filename(import_record, parsed, config)
        if config.find_by_isbn?
          import_record.filename ||= parsed.isbn
        else
          import_record.filename ||= parsed.title
        end
      end
    end #ParserHandler
  end #PublisherTools
end #MetadataParser
