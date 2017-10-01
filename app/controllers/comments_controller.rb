class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @post = Post.find(params[:post_id])
    respond_with(
      @comment = @post.comments.create(comment_params.merge(user: current_user)),
      location: post_path(@post)
    )
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
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
end
