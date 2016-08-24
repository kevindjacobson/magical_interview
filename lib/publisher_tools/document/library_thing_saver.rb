module PublisherTools::Document::LibraryThingSaver
  # LibraryThing ApiAccount that I created.

  def api_account
    ApiAccount.find(37928)
  end

  def save_library_thing_information
    process_library_thing_stats
    process_library_thing_reviews
    process_library_thing_recommendations
  end

  def process_library_thing_stats
    return if !@library_thing_stats
    stat = LibraryThingStat.find_or_initialize_by_word_document_id(word_document.id)

    # Register hits with analytics.
    ANALYTICS_COLLECTOR.register_hit(
      :page_type => "doc_library_thing_average#{@library_thing_stats[:avg_rating]}",
      :page_id => word_document.id
    )

    ANALYTICS_COLLECTOR.register_hit(
      :page_type => "doc_library_thing_num_ratings#{@library_thing_stats[:num_ratings]}",
      :page_id => word_document.id
    )

    # Save new stat
    stat.num_ratings = @library_thing_stats[:num_ratings]
    stat.avg_rating = @library_thing_stats[:avg_rating]
    stat.times_favorited = @library_thing_stats[:times_favorited]
    stat.word_document = word_document
    stat.save!
  end

  def process_library_thing_reviews
    return if !@library_thing_reviews

    @library_thing_reviews.each do |workcode, reviews|
      reviews.each do |review_id, review_content|
        review_text = review_content[:review_text]
        stars = review_content[:stars]
        user_id = review_content[:user_id]
        time_written = review_content[:time_written]

        # Set the time for created_at and updated_at
        Timecop.freeze(time_written) do
          word_user = ApiUniqueId.for_api_user(api_account.id, user_id).first.try(:word_user)
          if !word_user
            word_user = WordUser.new
            word_user.login = WordUser.find_unused_login_for(user_id)
            word_user.password = String.random
            word_user.save!

            ApiUniqueId.create!(:word_user => word_user, :api_account => api_account, :unique_id => user_id)
          end

          rating = nil

          if !stars.blank?
            rating = Rating.find_or_initialize_by_word_document_id_and_word_user_id(word_document.id, word_user.id)

            rating.score = stars.to_f.round
            rating.ip_address = 0
            rating.source = Rating::DATA_SOURCES[:library_thing]
            rating.save!
          end

          review = Review.find_or_initialize_by_word_document_id_and_word_user_id(word_document.id, word_user.id)
          review.rating_id = rating.id if rating
          review.review_text = review_text[0..Review::MAX_REVIEW_LENGTH]
          review.source = "library_thing"

          # Save these two explicitly despite Timecop block to fix cases where we have a nil created_at and updated_at.
          review.created_at = time_written
          review.updated_at = time_written
          review.save!
        end
      end
    end
  end

  def process_library_thing_recommendations
    return if !@library_thing_recommendations

    @library_thing_recommendations.each do |workcode, recommendations|
      recommendations.each do |recommendation_id, recommendation_content|
        recommendation = recommendation_content[:recommendation]
        library_thing_ranking = recommendation_content[:library_thing_ranking]
        unless recommendation == word_document.id
          recommendation = LibraryThingRecommendation.find_or_initialize_by_source_document_id_and_recommendation_id(word_document.id, recommendation)
          recommendation.library_thing_ranking = library_thing_ranking
          recommendation.save!
        end
      end
    end
  end
end
