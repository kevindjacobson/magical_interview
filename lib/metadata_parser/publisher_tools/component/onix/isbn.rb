module MetadataParser
  module PublisherTools
    module Component
      module Onix
        class Isbn
          extend ::MetadataParser::PublisherTools::Component::Onix::CodeTable
          include ::MetadataParser::PublisherTools::Component::Onix::Base

        end #Isbn
      end #Onix
    end #Component
  end #PublisherTools
end #MetadataParser
