class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    following = user.followings.create(following_params)
    @follower = following.following_user
    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end

  def destroy
    user
    following = Following.find(params[:id])
    @follower = following.following_user
    following.destroy

    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end
  
  def following_params
    params.permit(:user_id, :following_user_id)
  end
end
