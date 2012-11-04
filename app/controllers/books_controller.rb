class BooksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :index]
 
  def new  
    @book=Book.new
  end

  def index
    @books=Book.all
  end

  def show
    @book=Book.find(params[:id])
  end

  def create
    @book=Book.new(params[:book])
    if @book.save
     flash[:success]="New book successfully created, you bookworm."
     redirect_to @book
    else
     render 'new'
    end
  end

end
