class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply_tweet = tweet.reply_tweets.create(tweet_params.merge(user: current_user))

    if @reply_tweet.save
      respond_to do |format|
        format.html { redirect_to tweet_path(tweet) }
        format.turbo_stream
      end
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.required(:tweet).permit(:body)
  end
end
