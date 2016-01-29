class RevisionsController < ApplicationController
  before_action :require_login, only: [:new, :create, :update, :destroy, :edit]
  load_and_authorize_resource

  def index
    @revisions = Article.find_by_slug(params[:article_id]).revisions
  end

  def create
    @revision = Revision.new(revision_params)

    if @revision.save
      return render json: { success: true, revision: @revision }
    else
      return render json: { success: false, errors: @revision.errors.full_messages }
    end
  end

  def new
    @revision = Revision.new
  end

  def edit
    @revision = Revision.find(params[:id])
  end

  def show
    @revision = Revision.find(params[:id])
  end

  def update
    @revision = Revision.find(params[:id])

    if @revision.update_attributes(revision_params)
      return render json: { success: true, revision: @revision }
    else
      return render json: { success: false, errors: @revision.errors.full_messages }
    end
  end

  def destroy
    @revision = Revision.find(params[:id])

    if @revision.destroy
      return render json: { success: true, revision: @revision }
    else
      return render json: { success: false, errors: @revision.errors.full_messages }
    end
  end

  private
  def revision_params
    params.require(:revision).permit(:article_id, :user_id, :content, :title)
  end
end
