class CommentsController < ApplicationController
  include CommentsHelper
  before_action :find_commentable
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    if @comment.save
      flash[:notice] = get_flash_notice
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, :alert => "Your comment wasn't posted!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body,:user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Question.find_by_id(params[:question_id]) if params[:question_id]
  end
end