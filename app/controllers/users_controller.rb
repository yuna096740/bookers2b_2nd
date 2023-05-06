class UsersController < ApplicationController

  before_action:is_maching_login_user, only:[:edit,:update]

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated profile successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def is_maching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
