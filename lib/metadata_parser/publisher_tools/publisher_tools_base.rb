module MetadataParser
  module PublisherTools
    class PublisherToolsBase < ::MetadataParser::ParserBase
      attr_accessor :publisher_tools_config

      def initialize(file, publisher_tools_config)
        super(file)
        self.publisher_tools_config = publisher_tools_config
      end
    end #PublisherToolsBase
  end #PublisherTools
end #MetadataParser

