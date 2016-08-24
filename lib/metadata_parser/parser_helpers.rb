require "set"
# MetadataParser parses generic blocks out of an initial metadata file.
# In other words, this takes a generic file that contains metadata for items A, B, C, and D.
# It then parses out the individual data for each block. It does not process the data.

# Once it has the split data you can create an import record and update the record with the data.

module MetadataParser
  # Abstract base class. Only class methods here!

  module ParserHelpers
    # Add your parser here if you create a new one
    def parsers
      @parsers ||= Set.new([PublisherTools::Onix,
                            PublisherTools::SpreadSheet])
    end

    def detect_parser(file)
      parsers.detect { |parser| parser.can_parse?(file) }
    end

    def parse_time(column, as_date = false)
      return column if column.is_a?(Time) || column.is_a?(DateTime) || column.is_a?(Date)
      return nil if column.blank? || Time.parse(column).blank?

      old_tz = Time.zone
      time = nil
      begin
        Time.zone = "UTC"
        time = Time.zone.parse(column)
      ensure
        Time.zone = old_tz
      end

      as_date ? time.to_date : time
    rescue ArgumentError => e
      raise unless e.message =~ /no time information/
      return nil
    end

    def parse_date(column)
      parse_time(column, true)
    end
  end
end
