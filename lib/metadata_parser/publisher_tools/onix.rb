module MetadataParser
  module PublisherTools
    class Onix < ::MetadataParser::PublisherTools::PublisherToolsBase
      attr_reader :schema_version
      filename_pattern /\.(?:xml)\Z/i

      def initialize(file, publisher_tools_config)
        super
        return unless valid?
        @schema_version = parse_schema_version(file)
      end

      def import_objects &block
        begin
          onix_reader = XmlIncrementalReader.new(file, "product")
          onix_reader.each_entity_string do |entity|
            yield parse_row(entity, publisher_tools_config)
          end
        rescue => e
          log_error("Onix parsing exception #{e} \n #{e.backtrace.join(", \n ")}")
        end
      end

      def log_error(message, level="error")
        errors.add(:base, message) if level == "error"
        message = "Onix \n " + message
        Scribd::Logger.for("publisher_tools_metadata").send(level, message)
      end

      def parse_schema_version(file)
        head = file.read(1024)
        file.rewind

        onix_message = get_tag(head, /<ONIXMessage[^>]*?>/i)
        doctype = get_tag(head, /<!DOCTYPE[^>]*?>/)
        if onix_message.include?("2.1") || doctype.include?("onix/2.1")
          "2.1"
        else
          errors.add(:base, "Must be ONIX version 2.1, found #{onix_message.inspect} and #{doctype.inspect}")
        end
      end

      private

      def parse_row(row, publisher_tools_config)
        PublisherTools::Row::Onix.new(row, publisher_tools_config)
      end

      def get_tag(head, regex)
        head.match(regex).try(:[], 0) || ''
      rescue
      end
    end #Onix
  end #PublisherTools
end #MetadataParser
