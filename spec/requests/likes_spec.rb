require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

  describe "POST create" do
    it "creates a new like" do
      expect { post tweet_likes_path(tweet), xhr: true }.to change { Like.count }.by(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "deletes a like" do
      like = create(:like, user: user, tweet: tweet)
      expect { delete tweet_like_path(tweet, like), xhr: true }.to change { Like.count }.by(-1)
      expect(response).to have_http_status(:success)
    end
  end
end
