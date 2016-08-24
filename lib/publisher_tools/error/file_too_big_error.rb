module PublisherTools::Error
  class FileTooBigError < PublisherError
    attr_reader :file_size, :limit
    
    def initialize(file_size=nil, limit=nil)
      @file_size = file_size
      @limit = limit
    end
  end
end