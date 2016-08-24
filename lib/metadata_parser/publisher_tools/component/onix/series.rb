module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Series
          include ::MetadataParser::PublisherTools::Component::Onix::Base
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable

          add_onix_code :series_identifier, "seriesidentifier", "SeriesIdentifier", :component => ::MetadataParser::PublisherTools::Component::Onix::SeriesIdentifier
          add_onix_code :title_element, "title", "Title", :component => ::MetadataParser::PublisherTools::Component::Onix::Title

          add_onix_code :issn, "b016", "SeriesISSN"
          add_onix_code :title_of_series, "b018", "TitleOfSeries"
          add_onix_code :position_entity, "b019", "NumberWithinSeries"


          def identifiers
            idens = []
            if series_identifier.present?
              idens.concat(series_identifier)
            elsif issn.present?
              idens << ::MetadataParser::PublisherTools::Component::Onix::SeriesIdentifier.create_from_issn(issn)
            end
            idens
          end

          def title
            title_of_series || title_element.title
          end

          def position
            position = /(\d+)/.match(position_entity)
            position[0].to_i if position.present?
          end

        end #Series
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser