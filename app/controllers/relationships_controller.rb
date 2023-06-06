class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user
  end

end
