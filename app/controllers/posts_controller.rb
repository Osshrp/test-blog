class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.where(is_published: true)
    respond_with @posts
  end

  def show
    if (current_user && current_user.author_of?(@post)) || @post.is_published?
      respond_with @post
    else
      redirect_to root_path
    end

  end

  def new
    respond_with(@post = current_user.posts.new)
  end

  def create
    respond_with(@post = current_user.posts.create(post_params))
  end

  def edit
  end

  def update
    @post.update(post_params)
    respond_with @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
