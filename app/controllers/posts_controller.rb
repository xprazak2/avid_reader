class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_post_owner, only: :destroy
  before_filter :admin_user, only: :destroy

  def new
    @book = Book.find(params[:book_id])
    @post = current_user.posts.build(book_id: @book.id)    
  end
  
  def create
    @book=Book.find(params[:book_id])    
    @post=current_user.posts.build(params[:post])
    @post.book = @book
    if @post.save
      flash[:success] = "New post created"
      redirect_to @book
    else
      render 'new'
    end    
  end
 
  def destroy
    @book=Book.find(params[:book_id])    
    @post = current_user.posts.find(params[:id])
    flash[:success] = "Post erased."
    redirect_to @book
  end

  private 
    def correct_post_owner
      @post = Post.find(params[:id])
      @user = User.find(@post.user_id)
      redirect_to(root_path) unless current_user?(@user)
    end

end
