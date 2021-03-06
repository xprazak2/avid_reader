class BooksController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :create ]
  before_filter :admin_user,  only: [:destroy, :new, :create]
  
  def new  
    @book=Book.new
  end

  def index
    @books=Book.paginate(page: params[:page])
  end

  def show
    @book=Book.find(params[:id])
    @posts=@book.posts.paginate(page: params[:page])
    
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

  def destroy
    @book=Book.find(params[:id]).destroy
    flash[:success]="Book deleted, are you going to burn it too?"
    redirect_to books_url
  end

end
