class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @invitations = current_user.request_received
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @user_friend_posts = @user.posts.include?(@friend)
  end
end
