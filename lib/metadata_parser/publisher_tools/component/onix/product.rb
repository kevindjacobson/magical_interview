module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Product
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
 
          # Row::Base creates these spreadsheet-only fields, which are then delegated to product by onix, but product has no idea what they are,
          #  so create accessors that return nil (unless eventually we parse these values from onix)
          attr_accessor :page_restriction_type, :page_restriction_value, :buy_url, :category, :tags, :download_and_drm, :flex_columns, :flex_schema,
                        :collections, :featured_collection, :list_price, :currency_code, :for_direct_purchase, :for_subscription


          add_onix_code :title_composite, "title", "Title", :component => ::MetadataParser::PublisherTools::Component::Onix::Title
          add_onix_code :other_text_composite, "othertext", "OtherText", :component => ::MetadataParser::PublisherTools::Component::Onix::OtherText
          add_onix_code :supply_detail_composite, "supplydetail", "SupplyDetail", :component => ::MetadataParser::PublisherTools::Component::Onix::SupplyDetail
          add_onix_code :content_item_composite, "contentitem", "ContentItem", :component => ::MetadataParser::PublisherTools::Component::Onix::ContentItem
          add_onix_code :language_composite, "language", "Language", :component => ::MetadataParser::PublisherTools::Component::Onix::Language
          add_onix_code :title_alt_entity, "b028", "DistinctiveTitle"
          add_onix_code :subtitle_alt_entity, "b029", "Subtitle"
          # j261+price_qualifier mean 'valid demo', 5 is for consumers
          add_onix_code :publication_date, "b003", "PublicationDate"
          add_onix_code :publishing_status, "b394", "PublishingStatus", :int
          add_onix_code :sales_rights, "salesrights", "SalesRights", :component => ::MetadataParser::PublisherTools::Component::Onix::SalesRight
          add_onix_code :authors, "contributor", "Contributor", :component => ::MetadataParser::PublisherTools::Component::Onix::Author
          add_onix_code :main_category, "b064", "BASICMainSubject"
          add_onix_code :sub_categories, "subject", "Subject", :component => ::MetadataParser::PublisherTools::Component::Onix::Category
          add_onix_code :imprint_composite, "imprint", "Imprint", :component => ::MetadataParser::PublisherTools::Component::Onix::Imprint
          add_onix_code :publisher_composite, "publisher", "Publisher", :component => ::MetadataParser::PublisherTools::Component::Onix::Imprint
          add_onix_code :page_count_entity, "b061", "NumberOfPages"
          add_onix_code :language_entity, "b059", "LanguageOfText"
          add_onix_code :audience_range, "audiencerange", "AudienceRange", :component => ::MetadataParser::PublisherTools::Component::Onix::Audience
          add_onix_code :audience_codes, "b073", "AudienceCode", :array
          add_onix_code :audience_grades, "b189", "USSchoolGrades"
          add_onix_code :audience_age, "b190", "InterestAge"
          add_onix_code :isbn_entity, "b004", "ISBN"
          add_onix_code :related_products, 'relatedproduct', 'RelatedProduct', :component => ::MetadataParser::PublisherTools::Component::Onix::RelatedProduct
          add_onix_code :product_id_isbns, "productidentifier", "ProductIdentifier", :component => ::MetadataParser::PublisherTools::Component::Onix::Isbn
          add_onix_code :work_id_isbns, "workidentifier", "WorkIdentifier", :component => ::MetadataParser::PublisherTools::Component::Onix::Isbn
          add_onix_code :series, "series", "Series", :component => ::MetadataParser::PublisherTools::Component::Onix::Series
          add_onix_code :year_first_published, 'b088', 'YearFirstPublished'

          def audience
            # Returns an audience component
            @audience ||= audience_range_handler || audience_codes_handler || audience_grades_handler ||
            audience_age_handler 
          end

          ["range", "codes", "grades", "age"].each do |m|
            define_method("audience_#{m}_handler") do
              ::MetadataParser::PublisherTools::Component::Onix::Audience.send("create_from_#{m}", self.send("audience_#{m}"))
            end
          end

          def imprints
            imprints = []
            imprints.push(imprint_composite)
            imprints.push(publisher_composite)
            imprints.flatten.compact
          end

          def full_title
            [ title, subtitle ].reject {|x| x.blank? }.join(": ")
          end

          def title
            decode_html_entities_and_clean(title_composite.try(:first).try(:title) || title_alt_entity)
          end

          def subtitle
            decode_html_entities_and_clean(title_composite.try(:first).try(:subtitle) || subtitle_alt_entity)
          end

          def description
            if other_text_composite.present?
              # Find the other_text composites with the correct type code
              descriptions = other_text_composite.collect { |otc| otc.description }

              desc = descriptions.compact.join("").strip
              val = decode_html_entities_and_clean(desc)
              return val unless val.blank?
            end
          end

          def isbn
            # Prioritize isbn 13 if both are present
            if product_id_isbns.present?
              identifier = product_id_isbns.find {|e| e.isbn_13?} ||
                           product_id_isbns.find {|e| e.isbn_10?}
              identifier.try(:isbn)
            end
          end

          def related_product_isbns
            if related_products.present?
              related_products.collect &:isbn
            end
          end

          def alternate_isbns
            arr = [isbn, isbn_entity]
            [product_id_isbns, work_id_isbns].each do |isbns|
              next if isbns.blank?
              isbns.each do |isbn|
                arr.push(isbn.isbn)
              end
            end
            arr.push(related_product_isbns)
            return arr.flatten.compact.uniq
          end
          alias_method :filename, :isbn

          def prices
            dated_prices
          end

          def publish_date
            sale_date = nil
            if supply_detail_composite.present?
              sale_date = supply_detail_composite.find { |sdc| sdc.sale_date.present? }.try(:sale_date)
            end

            date = sale_date || book_publication_date
            if date
              MetadataParser::ParserBase.parse_time(date)
            else
              false
            end
          end

          def book_publication_date
            publication_date
          end

          def page_count
            page_count_entity || page_count_alt_entity
          end

          def page_count_alt_entity
            if content_item_composite
              content_item_composite.find { |cic| cic.page_count.present? }.try(:page_count)
            end
          end

          def language
            language_entity || language_alt_entity 
          end  

          def language_alt_entity
            if language_composite.present?
              language_comp = language_composite.find { |lc| lc.language.present? }
              language_comp.try(:language)
            end
          end

          def deleting
            if DELETING_CODES.include?(availability_code) || DELETING_STATUSES.include?(publishing_status) ||
              DELETING_AVAILABILITIES.include?(product_availability) || forthcoming? && !publish_date
              true
            else
              false
            end
          end

          def availability_code
            if supply_detail_composite.present?
              supply_detail_composite.find { |sdc| sdc.availability_code.present? }.try(:availability_code)
            end
          end

          def product_availability
            if supply_detail_composite.present?
              supply_detail_composite.find { |sdc| sdc.product_availability.present? }.try(:product_availability)
            end
          end

        private

          def pad_date(date)
            # Convert YYYY and YYYYMM dates into YYYYMMDD
            if date.length == 4
              date << "0000"
            elsif date.length == 6
              date << "00"
            else
              date
            end
          end

          def decode_html_entities_and_clean(str)
            str = html_entity_coder.decode(str)
            str.gsub!(/<\/?[^>]*>/, '') # remove html tags
            str.gsub!(/[[:cntrl:]]/, '') # remove control characters
            str.gsub!(/&[a-zA-Z#\d]{1,7};/, '') # remove unknown HTML entities
            str
          end

          def html_entity_coder
            @html_entity_coder ||= HTMLEntities.new
          end

          def dated_prices
            prices = []
            if supply_detail_composite.present?
              # find a supply detail composite with a price entity
              details = supply_detail_composite.select {|sd| sd.price_entity.present?}
              details.each do |supply_detail|
                prices.push supply_detail.try(:price_entity)
              end
              prices = prices.flatten.compact
              return prices
            end
          end

          def bisac_categories
            categories = []
            categories = self.sub_categories.select(&:is_bisac?).collect(&:code) if self.sub_categories
            categories.push(main_category)
            #No sense repeating categories here. Or allowing nil.
            return categories.compact.uniq
          end

          def forthcoming?
            return true if FORTHCOMING_CODES.include?(availability_code) ||
            FORTHCOMING_STATUSES.include?(publishing_status) ||
            FORTHCOMING_AVAILABILITIES.include?(product_availability)
            false
          end

          #for AvailabilityCode / j141 (list 54)
          DELETING_CODES = Set.new(%w{AB AD EX OF OI OP OR PP RF WS})
          FORTHCOMING_CODES = Set.new(%w{NP NY TU UR})
          #for PublishingStatus / b394 (list 64)
          DELETING_STATUSES = Set.new([1, 3, 5, 7, 11, 12, 15, 16])
          FORTHCOMING_STATUSES = Set.new([2])
          #for ProductAvailability / j396 (list 65)
          DELETING_AVAILABILITIES = Set.new([1, 34, 40, 41, 42, 43, 45, 46, 48, 49, 50, 51, 52])
          FORTHCOMING_AVAILABILITIES = Set.new([10, 11, 12, 30, 31, 32, 33])
            
        end #Product
      end  #Onix
    end  #Component
  end  #PublisherTools
end  #MetadataParser