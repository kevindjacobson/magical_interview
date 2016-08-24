module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class ContentItem
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

          add_onix_code :text_item_composite, "textitem", "TextItem", :component => ::MetadataParser::PublisherTools::Component::Onix::TextItem

          def page_count
            text_item_composite.first.page_count  # textitems only occur once in contentitems
          end
        end #ContentItem
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
