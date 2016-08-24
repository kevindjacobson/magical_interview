module MetadataParser
  module PublisherTools
    module Row
      class Base < ::MetadataParser::Row::RowBase
        add_fields [
          :full_title,
          :description,
          :isbn,
          :alternate_isbns,
          :category,
          :authors,
          :deleting,
          { :pricing => [:prices, :list_price] },
          :sales_rights,
          :tags,
          :filename,
          :bisac_categories,
          :buy_url, #formerly "link_back_url"
          :download_and_drm,
          { :page_restriction => [:page_restriction_type, :page_restriction_value] },
          { :collections => [:collections, :featured_collection, :series] },
          { :flex_columns => [:flex_schema, :flex_columns] },
          { :book => [:book_publication_date, :year_first_published, :audience, :title, :subtitle] },
          :publish_date,
          :imprints,
          :page_count,
          :language,
          :library_thing_information,
          :series,
          :currency_code,
          :for_subscription,
          :for_direct_purchase
        ]
        attr_accessor *accessors

        def validate!
          validate_page_restriction_type
          validate_buy_url
          validate_isbn_and_filename
          validate_prices
          validate_y_or_n
        end

        def validate_page_restriction_type
          if page_restriction_type.present? &&
            !PaidDocument::PAGE_CALCULATION_METHODS.include?(page_restriction_type)
            errors.add(:page_restriction_type, "should be one of #{PaidDocument::PAGE_CALCULATION_METHODS.join(', ')}, was #{page_restriction_type}")
          end
          true
        end

        def validate_buy_url
          if buy_url.try("!~", /^http(s)?\:\/\//)
            errors.add(:buy_url, "'#{buy_url}' is not a website ")
          end
          true
        end

        def validate_isbn_and_filename
          if isbn.blank? && filename.blank?
            errors.add(:filename, "Missing both filename and ISBN")
          end
          if isbn == ""
            # You should set it to nil instead...
            errors.add(:isbn, "can not be an empty string")
          end
          true
        end

        def featured_collection_object
          return nil if featured_collection.blank?
          DocumentCollection.on_slow_slave.first(:conditions =>
                                                 {:name => featured_collection, :word_user_id  => publisher_tools_config.word_user_id })
        end

        def validate_prices
          if prices.present? && prices.length > 1 &&
            prices.detect {|price_date| price_date.retail_price == 0}
            errors.add(:prices, "PublisherTools does not support mixing paid and free prices")
          end
        end

        def validate_y_or_n
          errors.add(:for_subscription, "must be Y, N, or blank") if not ["", "Y", "N"].include?(for_subscription.to_s)
          errors.add(:for_direct_purchase, "must be Y, N, or blank") if not ["", "Y", "N"].include?(for_direct_purchase.to_s)
        end
      end # base
    end # row
  end # publisher tools
end #metadata parser
