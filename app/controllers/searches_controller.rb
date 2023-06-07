class SearchesController < ApplicationController

  def search
    @book = Book.new
    @books = Book.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
