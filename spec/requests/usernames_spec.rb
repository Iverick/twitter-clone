require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  let(:user) { create(:user, username: nil) }

  before { sign_in user }

  describe "GET new" do
    it "is successful" do
      get new_username_path
      expect(response).to have_http_status(:success)  
    end
  end

  describe "PUT update" do
    it "updates the username" do
      expect do
        put username_path(user), params: {
          user: {
            username: "foobaz"
          }
        }
      end.to change { user.reload.username }.from(nil).to("foobaz")

      expect(response).to redirect_to dashboard_path
    end
  end
end
