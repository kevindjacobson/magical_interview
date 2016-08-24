require "active_support/memoizable"
require "nokogiri"
module MetadataParser
  module PublisherTools
    module Row
      class SpreadSheet < ::MetadataParser::PublisherTools::Row::Base
        include ActiveSupport::Memoizable

        COLUMN_TYPES = {
          :title                          => :string,
          :subtitle                       => :string,
          :filename                       => :string,
          :description                    => :string,
          :tags                           => :string,
          :isbn                           => :string,
          :parent_isbn                    => :string,
          :category                       => :string,
          :author_names                   => :comma_delimited_array,
          :list_price                     => :string,
          :price                          => :price,
          :download_and_drm               => :drm,
          :page_restriction_type          => :downcase_string,
          :page_restriction_value         => :downcase_string,
          :page_restriction_percent       => :liberal_percent,
          :publish_date                   => :time,
          :original_ebook_pub_date        => :time,
          :buy_url                        => :string,
          :collections                    => :string,
          :featured_collection            => :string,
          :my_user_id                     => :string,
          :deleting                       => :boolean,
          :link_back_url                  => :string,
          :imprint                        => :string,
          :permitted_sales_territories    => :comma_delimited_array,
          :excluded_sales_territories     => :comma_delimited_array,
          :bisac_categories               => :comma_delimited_array,
          :page_count                     => :string,
          :currency_code                  => :string,
          :series_name                    => :string,
          :language                       => :downcase_string,
          :for_subscription               => :string,
          :for_direct_purchase            => :string
        }

        attr_accessor *COLUMN_TYPES.keys.compact

        attr_accessor :schema, :publisher_tools_config, :flex_schema, :raw_data

        def self.schema_from_version(version)
          PublisherTools::SpreadSheet.schema_columns_from_version(version)
        end

        def initialize(data, publisher_tools_config, schema_version, flex_schema)
          self.publisher_tools_config = publisher_tools_config
          self.schema = self.class.schema_from_version(schema_version)
          populate_flex_fields(flex_schema, data)
          populate_schema_fields(data)
          self.raw_data = data.dup
          set_prices
          set_sales_rights
          set_authors
          set_series
          if self.page_restriction_percent.present?
            self.page_restriction_type = 'max_percentage'
            self.page_restriction_value = self.page_restriction_percent
          end

          #Set isbn to nil if it was previously set to a blank string
          self.isbn = nil if self.isbn.blank?

          #Remove the extension
          self.filename = File.basename(self.filename, ".*")
          validate!
        end

        def set_prices
          self.price ||= self.list_price
          self.prices = [PublisherTools::Component::DatedPrice.new({ :price => price, :list_price => list_price })]
        end

        def set_sales_rights
          self.sales_rights = []
          if permitted_sales_territories.present?
            self.sales_rights << PublisherTools::Component::SalesRight.new('allowed', permitted_sales_territories)
          elsif excluded_sales_territories.present?
            self.sales_rights << PublisherTools::Component::SalesRight.new('banned', excluded_sales_territories)
          elsif permitted_sales_territories == [] && excluded_sales_territories == []
            # By default, the book is available everywhere if these cols are present but blank.
            self.sales_rights << PublisherTools::Component::SalesRight.new('banned', [])
          end
          if permitted_sales_territories.present? && excluded_sales_territories.present?
            self.errors.add(:base, "Only one of the 'Permitted Sales Territories' and 'Excluded Sales Territories' columns may be filled out")
          end
        end

        def set_authors
          if !author_names.nil?
            self.authors = author_names.map { |name|
              author_component = PublisherTools::Component::Author.new
              author_component.name = name
              author_component
            }
          end
        end

        def set_series
          if !series_name.nil?
            series = PublisherTools::Component::Series.new
            series.title = series_name
            self.series = [series]
          end
        end

        def book_publication_date
          # return date in 'YYYYMMDD' format
          if original_ebook_pub_date.present?
            original_ebook_pub_date.strftime("%Y%m%d")
          elsif publish_date.present?
            publish_date.strftime("%Y%m%d")
          end
        end

        def imprints
          component = MetadataParser::PublisherTools::Component::Imprint.new
          component.name = imprint
          [component]
        end

        def alternate_isbns
          if parent_isbn && parent_isbn != isbn
            [parent_isbn]
          else
            []
          end
        end

        def full_title
          if subtitle.present?
            title + ': ' + subtitle
          else
            title
          end
        end

        private

        def populate_schema_fields(row)
          schema.each_with_index do |column_name, index|
            next if column_name.nil?

            send "#{column_name}=", parse_column(row[index], column_name)
          end
        end

        def populate_flex_fields(flex_schema, data)
          self.flex_columns = {}
          return {} if flex_schema.blank?

          #schema.length is the number of scribd defined fields, and flex columns always come after scribd columns
          #so taking data from scribd fields -> the end, gives us the flex-fields.
          #If we have no flex-data for this row, default to an empty array.

          flex_rows = data[schema.length..-1] || []
          flex_schema.each_with_index do |column_name, index|
            self.flex_columns[column_name] = flex_rows[index].to_s
          end
        end

        def parse_column(column, column_name)
          case COLUMN_TYPES[column_name]
          when :string
            column.to_s
          when :downcase_string
            column.to_s.downcase
          when :price
            parse_price(column)
          when :drm
            map_download_and_drm(column)
          when :boolean
            !!(column.to_s.strip =~ /^(?:y(?:es)?|ok(?:ay)?|t(?:rue)?|x|1)$/i)
          when :time
            MetadataParser::ParserBase.parse_time(column)
          when :comma_delimited_array
            column.to_s.split(",").map { |s| s.strip }
          when :liberal_percent
            val = column.to_f
            val < 1 ? (val * 100).to_i : val.to_i
          else
            # This should never happen: names -> type mappings are set by a constant hash.
            # Column names come from the version hash, so there is no user-supplied data.
            # If this does happen, it's a programmer error.
            raise ArgumentError.new("Unparsable column named: #{column_name}")
          end
        end

        def parse_price(column)
          # Legacy code to clean up ugly pricing.
          parsed_column = column.to_s.strip.
            gsub(/^\$/, '').
            gsub(/<\/?[^>]*>/, '').
            gsub(/[[:cntrl:]]/,'').
            strip
          BigDecimal.new(parsed_column.blank? ? '0.0' : parsed_column)
        end

        # Map human-readable download/drm options to API value.
        def map_download_and_drm(str)
          case str
          when /DRM/i
            'download-drm'
          when /Orig/i
            'download-pdf-orig'
          when /PDF/i, /EPUB/i
            'download-pdf'
          when /copy/i
            'view-without-copy-paste'
          when /view/i
            'view-only'
          when nil, /\A\s*\Z/
            publisher_tools_config.download_and_drm
          else
            errors.add(:download_and_drm, "Unknown drm type #{str}")
          end
        end
      end #Spreadsheet
    end #Row
  end #PublisherTools
end #MetadataParser
