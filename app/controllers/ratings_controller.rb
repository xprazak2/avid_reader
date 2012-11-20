class RatingsController < ApplicationController
  before_filter :signed_in_user

  def create
    @book = Book.find(params[:book_id])
    @rating = current_user.ratings.build(params[:rating])
    @rating.book = @book
    if @rating.save
      flash[:success] = "Book rated"
      redirect_to Book.find(params[:book_id])
    else
      redirect_to Book.find(params[:book_id])
    end
  end

end
