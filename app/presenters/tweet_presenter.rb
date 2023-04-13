class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = user
  end

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes, :retweets, :likes_count, :retweets_count, :reply_tweets_count, :views_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d") 
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def avatar
    return user.avatar if user.avatar.present?

    ActionController::Base.helpers.asset_path("userpic.png")
  end

  # Like helper methods
  def like_tweet_url(source: "tweet_card")
    if tweet_liked_by_current_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet), source: source)
    else
      tweet_likes_path(tweet, source: source)
    end
  end

  def like_turbo_data_method
    tweet_liked_by_current_user? ? "delete" : "post"
  end

  def like_icon
    tweet_liked_by_current_user? ? "bi-heart-fill" : "bi-heart"
  end

  def like_icon_class
    tweet_liked_by_current_user? ? "liked" : "like"
  end

  # Bookmark helper methods
  def bookmark_tweet_url(source: "tweet_card")
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet: tweet), source: source)
    else
      tweet_bookmarks_path(tweet, source: source)
    end
  end

  def bookmark_turbo_data_method
    tweet_bookmarked_by_current_user? ? "delete" : "post"
  end

  def bookmark_icon
    tweet_bookmarked_by_current_user? ? "bi-bookmark-fill" : "bi-bookmark"
  end

  def bookmark_link_text
    tweet_bookmarked_by_current_user? ? "Bookmarked" : "Bookmark"
  end

  # Retweet helper methods
  def retweet_url(source: "tweet_card")
    if tweet_retweeted_by_current_user?
      tweet_retweet_path(tweet, current_user.retweets.find_by(tweet: tweet), source: source)
    else
      tweet_retweets_path(tweet, source: source)
    end
  end

  def retweet_turbo_data_method
    tweet_retweeted_by_current_user? ? "delete" : "post"
  end

  def retweet_icon_class
    tweet_retweeted_by_current_user? ? "retweeted" : "retweets"
  end

  private

  def tweet_liked_by_current_user
    @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
  end
  alias_method :tweet_liked_by_current_user?, :tweet_liked_by_current_user

  def tweet_bookmarked_by_current_user
    @tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(current_user)
  end
  alias_method :tweet_bookmarked_by_current_user?, :tweet_bookmarked_by_current_user

  def tweet_retweeted_by_current_user
    @tweet_retweeted_by_current_user ||= tweet.retweeted_users.include?(current_user)
  end
  alias_method :tweet_retweeted_by_current_user?, :tweet_retweeted_by_current_user
end