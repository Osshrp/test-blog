class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_comment, only: [:edit, :destroy, :update]

  def create
    @post = Post.find(params[:post_id])
    respond_with(
      @comment = @post.comments.create(comment_params.merge(user: current_user)),
      location: post_path(@post)
    )
  end

  def edit
    if @comment.can_change?
      respond_with(@comment)
    else
      redirect_to post_path(@comment.post)
    end
  end

  def update
    if @comment.can_change?
      @comment.update(comment_params)
      respond_with(@comment, location: post_path(@comment.post))
    else
      respond_with(@comment, location: post_path(@comment.post))
    end
  end

  def destroy
    if @comment && @comment.can_change?
      respond_with(@comment.destroy, location: post_path(@comment.post))
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
  end
end
