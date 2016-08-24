# Read the XML file incrementally and use regex to extract each
# <object>stuff</object> that we are interested in
#
# If the entity does not fit within :working_buffer_size bytes, then
# the parsing stops to prevent running out of memory.
#
# Example:
#   Read a File object and extract "product" entities one at a time.
#
#   reader = XmlIncrementalReader.new(File.new("/foo/bar.xml"), "product")
#   reader.each_entity_string do |entity_as_string|
#     /* go wild with your string */
#   end
#
#   Read some XML and view the first block read, or to just manually go 
#   through the file.
#
#   Note: I'm not sure if this actually works or if this is for the future
#
#   reader = XmlIncrementalReader.new(File, "product", 
#                                     :working_buffer_size => 200.kilobytes,
#                                     :input_buffer_size => 5.kilobytes)
#   reader.read_another_block
#   reader.working_buffer
#   reader.match_entity
#   reader.entity_string # returns the first entity extracted from
#                        # working_buffer, is empty if none found.

module MetadataParser
  class XmlIncrementalReader
    attr_reader :working_buffer, :entity_string, :file

    def initialize(file, entity_tag, options = {})
      opts = options.dup
      @working_buffer_size = opts.delete(:working_buffer_size) || 1000.kilobytes + 1
      @input_buffer_size = opts.delete(:input_buffer_size) || 200.kilobytes
      raise ArgumentError.new("Unknown options: #{opts.keys.inspect}") unless opts.empty?

      @file = file
      @entity_tag = entity_tag
      # Reduce String object generation by reusing the String object
      @input_buffer = ""
      @working_buffer = ""
      @entity_string = nil
    end

    # Using regular expressions to parse XML is not generally recommended.
    def entity_regexp
      @entity_regexp ||= /(\s*<#{@entity_tag}(\s[^>\/]*)*>.*?<\/#{@entity_tag}>\s*|\s*<#{@entity_tag}(\s[^>]*\/)>)/im
    end

    def read_another_block
      c = @file.read(@input_buffer_size, @input_buffer)
      if c.nil?
        false
      else
        @working_buffer << @input_buffer
        true
      end
    end

    def match_entity(regexp = entity_regexp)
      @entity_string = @working_buffer.slice!(regexp)
    end

    def working_buffer_has_room?
      @working_buffer.size <= (@working_buffer_size - @input_buffer_size)
    end

    def each_entity_string
      loop do
        read_another_block while !match_entity && working_buffer_has_room? && !@file.eof?
        break if @entity_string.nil?

        yield @entity_string
        @entity_string = nil
      end
    end
  end
end
