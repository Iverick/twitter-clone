require "rails_helper"

RSpec.describe "Tweets", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before do 
    sign_in user
    allow(ViewTweetJob).to receive(:perform_later)
  end

  describe "GET show" do
    it "succeeds" do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success) 
    end

    it "queues up ViewTweetJob" do
      get tweet_path(tweet)
      expect(ViewTweetJob).to have_received(:perform_later).with(user: user, tweet: tweet)
    end
  end

  describe "POST create" do
    context "when not signed in" do
      it "is responds with redirect" do
        post tweets_path, params: {
          tweet: {
            body: "Tweet body"
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when logged in" do
      it "creates a new tweet" do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: {
              body: "Tweet body"
            }
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
