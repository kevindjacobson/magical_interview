module MetadataParser
  module PublisherTools
    class SpreadSheet < ::MetadataParser::PublisherTools::PublisherToolsBase
      filename_pattern /\.(?:xls)\Z/i

      TEMPLATE_RULES = {
        :v1 => {
          :columns => [nil, nil, :title, :filename, :description, :tags,
                       :category, :isbn, :list_price, :price, :download_and_drm, nil, nil,
                       nil, :link_back_url],
                       :start_row => 15
        },
        :v2 => {
          :columns => [nil, nil, :title, :filename, :description, :tags, :category,
                       :isbn, nil, :list_price, :price, :download_and_drm, nil, nil,
                       :publish_date, :link_back_url],
                       :start_row => 15
        },
        :v3 => {
          :columns => [:title, :filename, :description, :tags, :category, :isbn,
                       nil, :list_price, :price, :download_and_drm, :page_restriction_type,
                       :page_restriction_value, :publish_date, :link_back_url],
                       :start_row => 3
        },
        :v4 => {
          :columns => [:title, :filename, :description, :tags, :category,
                       :isbn, nil, :list_price, :price, :download_and_drm,
                       :page_restriction_type, :page_restriction_value, :publish_date,
                       :link_back_url, :collections, :featured_collection, :deleting],
                       :start_row => 3
        },
        :v5 => {
          :columns => [nil, :imprint, :parent_isbn, :isbn, nil, :filename,
                       :title, :subtitle, :author_names, :original_ebook_pub_date, :publish_date,
                       :list_price, :currency_code, :permitted_sales_territories,
                       :excluded_sales_territories, :description, :bisac_categories,
                       :page_count, :series_name, :deleting, :for_direct_purchase,
                       :for_subscription, :page_restriction_percent, :language],
                       :start_row => 6
        }
      }.with_indifferent_access

      attr_accessor :rows, :schema, :flex_schema, :start_row

      def initialize(file, publisher_tools_config)
        super
        populate_rows
        populate_schema
      end

      def schema_version
        return @version if @version

        # Look for a "version" field. Depending on the schema it's at (1, 1), (0, 1), or (1, 3).

        version_num = [rows[1][1], rows[0][1], rows[1][3]].detect{|x| x.to_i > 0}.try(:to_i)

        if version_num
          if version_num <= 5
            "v#{version_num}".to_sym
          else
            self.errors.add(:base, "Invalid Schema Version v#{version_num}")
          end
        else
          return :v3
        end
      end

      def import_objects &block
        rows.each_with_index do |row, index|
          # We need to skip some rows in some schema versions
          next if index < start_row
          parsed = parse_row(row, publisher_tools_config, flex_schema)

          yield(parsed)
        end
      end

      def self.schema_columns_from_version(version)
        TEMPLATE_RULES[version][:columns].dup
      end

      private

      def parse_row(row, publisher_tools_config, flex_schema)
        Row::SpreadSheet.new(row, publisher_tools_config, schema_version, flex_schema)
      end

      def populate_schema
        version = schema_version
        self.start_row = TEMPLATE_RULES[version][:start_row]
        self.schema = self.class.schema_columns_from_version(version)
        flex_header if schema_version == :v4
      end

      def populate_rows
        return populate_rows_excel
      end

      def assign_defaults()
        # No defaults for spreadsheets
      end

      def populate_rows_excel
        xls = Spreadsheet.open(file)
        sheet = xls.worksheet 0
        self.rows = []
        row_count = sheet.row_count

        sheet.each_with_index do |row, idx|
          begin
            current_row = []
            next if row.blank?
            next if row.compact.blank?
            row.each do |column|
              col = (column.respond_to?(:value) ? column.value : column)
              # ISBN strings get really weird if we don't do this...
              col = col.to_i if col.respond_to?(:to_i) && col.to_i == col
              col = nil if col == 0
              current_row << col
            end
            self.rows << current_row
          rescue => e
            errors.add(:base, "Spreadsheet parsing exception at row #{idx}")
            log_error("Could not parse row #{idx}")
          end
        end
      end

      def flex_header
        header_row = rows[start_row - 1]
        flex_start_index = schema.length
        self.flex_schema = header_row[flex_start_index..header_row.length]
      end

      def log_error(message, level="error")
        message = "Spreadsheet \n" + message
        Scribd::Logger.for("publisher_tools_metadata").send(level, message)
      end
    end # Spreadsheet
  end # PublisherTools
end #MetadataParser
