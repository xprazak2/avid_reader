class RatingsController < ApplicationController
  before_filter :signed_in_user

  def create
    @book = Book.find(params[:book_id])
    @rating = current_user.ratings.build(params[:rating])
    @rating.book = @book
    if @rating.save
      flash[:success] = "Book rated"
      redirect_to @book
    else
      flash[:error] = "Submitted rating was not a number between 0 and 100"
      redirect_to @book
    end
  end

end
