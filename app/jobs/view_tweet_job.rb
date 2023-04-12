class ViewTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet:, user:)
    View.create(user: user, tweet: tweet) unless tweet_viewed?(user: user, tweet: tweet)
  end

  private

  def tweet_viewed?(user:, tweet:)
    View.exists?(user: user, tweet: tweet)
  end
end
