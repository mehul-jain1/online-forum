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
      invoke_cables
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

  def invoke_cables
    CommentsController.renderer.instance_variable_set(:@env, {"HTTP_HOST"=>"localhost:3000", 
      "HTTPS"=>"off", 
      "REQUEST_METHOD"=>"GET", 
      "SCRIPT_NAME"=>"",   
      "warden" => warden})
    question = find_question(@comment)
    html = CommentsController.render(partial: 'comments/comment', collection: get_comments(question))
    NotificationRelayJob.perform_later('comment', html, question.id)
  end

  def get_comments(question)
    return nil if question.nil?
    question.comments if question
  end

  def find_question(comment)
    return nil if comment.nil?
    if comment.commentable_type == 'Question'
      question = Question.find_by_id(comment.commentable_id)
    elsif comment.commentable_type == 'Comment'
      question = Question.find_by_id(comment.commentable.commentable_id)
    end
    question
  end

end