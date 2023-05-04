class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
end
