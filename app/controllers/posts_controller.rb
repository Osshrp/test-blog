class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:index, :show]

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).where(is_published: true)
        .page(params[:page]).order('created_at DESC')
    else
      @posts = Post.where(is_published: true)
        .page(params[:page]).order('created_at DESC')
    end
    @posts = Post.where(user: current_user)
      .page(params[:page]).order('created_at DESC') if params[:my_posts]


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

  def destroy
    @post.destroy
    respond_with @post
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :is_published, :tag_list)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tags
    @tags = Post.tag_counts_on(:tags)
  end
end
