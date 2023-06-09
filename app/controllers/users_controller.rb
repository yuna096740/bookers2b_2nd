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

    @thisWeekBook = @books.created_this_week
    @lastWeekBook = @books.created_last_week

    if @books.created_each_date(1).count == 0
      @theDayBefore = "前日の投稿はなし"
    else
      @theDayBefore = @books.created_each_date(0).count / @books.created_each_date(1).count * 100.round
    end

    if @lastWeekBook.count == 0
      @theWeekBefore = "前週の投稿はなし"
    else
      @theWeekBefore = @thisWeekBook.count / @lastWeekBook.count * 100.round
    end
  end

  def searchBookCount
    @user = User.find(params[:user_id])
    @books = @user.books
    if params[:created_at] == ""
      @searchBook = "日付を検索してください"
    else
      @create_at = params[:created_at]
      @searchBook = @books.where(['created_at LIKE?', "#{@create_at}%"])
    end
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
