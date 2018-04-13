class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.page(params[:page]).order('created_at DESC')
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new
    end
  end

  def edit
    if @post.user != current_user
      redirect_to root_path, alert: "You can only edit your own posts!"
    end
  end

  def update
    if @post.user != current_user
      redirect_to root_path, alert: "You can only edit your own posts!"
    else
      if @post.update(post_params)
        redirect_to @post, notice: "Post updated successfully!"
      else
        render :edit
      end
    end
  end

  def destroy
    if @post.user != current_user
      redirect_to root_path, alert: "You can only delete your own posts!"
    else
      if @post.destroy
        redirect_to posts_path, notice: "Post deleted successfully!"
      else
        redirect_to @post, alert: "Could not delete the post!"
      end
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def resource_not_found
      redirect_to root_path, alert: "The post you are looking for could not be found."
    end
end
