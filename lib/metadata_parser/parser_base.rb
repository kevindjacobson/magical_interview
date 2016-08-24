# Abstract class for parsing things!

module MetadataParser
  class ParserBase
    extend ParserHelpers
    # these are so we can use model-less AR validations
    def save; end; def save!; end;
    include ActiveRecord::Validations

    def valid?
      errors.empty?
    end

    attr_accessor :file

    def initialize(file)
      self.file = file
      errors.add(:base, "File is empty") if File.zero?(file.path)
    end

    def self.filename_pattern(new_pattern=nil)
      if new_pattern.nil?
        @filename_pattern
      else
        @filename_pattern = new_pattern
      end
    end

    def self.can_parse? file
      file.path =~ filename_pattern
    end

    def import_objects &block
      raise "Must be implemented in subclass"
    end

    def parser
      raise "Must be implemented in subclass"
    end
  end
end
