require "rails_helper"

RSpec.describe "Bookmarks", type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get bookmarks_path
      expect(response).to have_http_status(:success)
    end
  end
  

  describe "POST create" do
    it "creates a new bookmark" do
      expect { post tweet_bookmarks_path(tweet), xhr: true }.to change { Bookmark.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE destroy" do
    it "deletes a bookmark" do
      bookmark = create(:bookmark, user: user, tweet: tweet)
      expect { delete tweet_bookmark_path(tweet, bookmark), xhr: true }.to change { Bookmark.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end

end
