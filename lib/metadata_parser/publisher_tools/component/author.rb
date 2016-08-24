module MetadataParser
  class PublisherTools::Component::Author
    attr_accessor(:name, :sequence, :description, :affiliation, :errors, :bowker_id)

    def is_author?
      return true
    end

    def sequence=(oth)
      @sequence = oth.to_i
    end
  end
end
