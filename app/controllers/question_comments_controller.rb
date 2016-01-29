class QuestionCommentsController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @question_comments = Question.find(params[:question_id]).question_comments
  end

  def create
    @question_comment = QuestionComment.new(question_comment_params)

    if @question_comment.save
      return render json: { success: true, question_comment: @question_comment }
    else
      return render json: { success: false, errors: @question_comment.errors.full_messages }
    end
  end

  def new
    @question_comment = QuestionComment.new
  end

  def edit
    @question_comment = QuestionComment.find(params[:id])
  end

  def show
    @question_comment = QuestionComment.find(params[:id])
  end

  def update
    @question_comment = QuestionComment.find(params[:id])

    if @question_comment.update_attributes(question_comment_params)
      return render json: { success: true, question_comment: @question_comment }
    else
      return render json: { success: false, errors: @question_comment.errors.full_messages }
    end
  end

  def destroy
    @question_comment = QuestionComment.find(params[:id])

    if @question_comment.destroy
      return render json: { success: true, question_comment: @question_comment }
    else
      return render json: { success: false, errors: @question_comment.errors.full_messages }
    end
  end

  private
  def question_comment_params
    params.require(:question_comment).permit(:content, :user_id, :article_id)
  end
end
