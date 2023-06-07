class SearchesController < ApplicationController

  def searchBook
    @book = Book.new
    @books = Book.search(params[:keyword])
    @keyword = params[:keyword]
  end

  def searchUser
    @book = Book.new
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
