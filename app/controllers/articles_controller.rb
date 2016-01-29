class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create, :update, :destroy, :edit]
  load_and_authorize_resource find_by: :slug

  def index
    @articles = Article.order('created_at DESC').page((params[:page] || 1))
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      return render json: { success: true, article: @article } 
    else
      return render json: { success: false, errors: @article.errors.full_messages }, status: 406
    end
  end

  def show
    @article = Article.find_by_slug(params[:id])
  end

  def edit
    @article = Article.find_by_slug(params[:id])
  end

  def update
    @article = Article.find_by_slug(params[:id])

    if @article.update_attributes(article_params)
      return render json: { success: true, article: @article }
    else
      return render json: { success: false, errors: @article.errors.full_messages }
    end
  end

  def destroy
    @article = Article.find_by_slug(params[:id])

    if @article.destroy
      return render json: { success: true }
    else
      return render json: { success: false, errors: @article.errors.full_messages }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tags, :user_id, :character_id, :game_id)
  end
end
