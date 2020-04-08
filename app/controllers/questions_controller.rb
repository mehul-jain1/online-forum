class QuestionsController < ApplicationController
  before_action :find_question, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:create, :edit]
  def new 
     @question = Question.new
  end

  def index
    @questions = get_questions
  end

  def create
    @question = @user.questions.new(question_params)
    if @question.save
      invoke_cables
      flash[:notice] = "Succesfully Posted"
      redirect_to @question
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update
     redirect_to @question
    else
     render 'edit'
    end
  end
 
  def destroy
    @question.destroy
    redirect_to questions_path
  end
 
  private

  def question_params
    params.require(:question).permit(:title, :description)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def set_user
    @user = current_user if current_user
  end

  def get_questions
    Question.all.order(created_at: :desc)
  end

  def invoke_cables
    html = ApplicationController.render(partial: 'questions/questions', locals: {questions: get_questions})
    NotificationRelayJob.perform_later('request', html)
  end
end