class QuestionsController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @article = Article.find_by_slug(params[:article_id])
    @questions = @article.questions
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      return render json: { success: true, question: @question }
    else
      return render json: { success: false, errors: @question.errors.full_messages }
    end
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update_attributes(question_params)
      return render json: { success: true, question: @question }
    else
      return render json: { success: false, errors: @question.errors.full_messages }
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      return render json: { success: true } 
    else
      return render json: { success: false, errors: @question.errors.full_messages }
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :user_id, :article_id)
  end
end
