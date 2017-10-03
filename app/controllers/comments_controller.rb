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
    respond_with(@comment)
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment, location: post_path(@comment.post))
  end

  def destroy
    if @comment
      respond_with(@comment.destroy, location: post_path(@comment.post))
    else
      respond_with('You dont have rights to delete with comment', location: posts_path)
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
