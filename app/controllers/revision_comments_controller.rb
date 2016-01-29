class RevisionCommentsController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @revision_comments = Revision.find(params[:revision_id]).revision_comments
  end

  def create
    @revision_comment = RevisionComment.new(revision_comment_params)

    if @revision_comment.save
      return render json: { success: true, revision_comment: @revision_comment }
    else
      return render json: { success: false, errors: @revision_comment.errors.full_messages }
    end
  end

  def new
    @revision_comment = RevisionComment.new
  end

  def edit
    @revision_comment = RevisionComment.find(params[:id])
  end

  def show
    @revision_comment = RevisionComment.find(params[:id])
  end

  def update
    @revision_comment = RevisionComment.find(params[:id])

    if @revision_comment.update_attributes(revision_comment_params)
      return render json: { success: true, revision_comment: @revision_comment }
    else
      return render json: { success: false, errors: @revision_comment.errors.full_messages }
    end
  end

  def destroy
    @revision_comment = RevisionComment.find(params[:id])

    if @revision_comment.destroy
      return render json: { success: true, revision_comment: @revision_comment }
    else
      return render json: { success: false, errors: @revision_comment.errors.full_messages }
    end
  end

  private
  def revision_comment_params
    params.require(:revision_comment).permit(:content, :user_id, :article_id)
  end
end
