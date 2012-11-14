class PostsController < ApplicationController
  before_filter :signed_in_user

  def new
    @book = Book.find(params[:book_id])
    @post = @book.posts.build(user_id: current_user.id)
    
  end
  
  def create
    @book=Book.find(params[:book_id])    
    @post=@book.posts.build(params[:post])
    @post.user = current_user
    if @post.save
      flash[:success] = "New post created"
      redirect_to @book
    else
      render 'new'
    end    
  end
 
  def destroy
  end

end
