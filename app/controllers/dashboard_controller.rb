class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end
end
