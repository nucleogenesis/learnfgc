class ArticlesController < ApplicationController
  def index
    @articles = Article.order('created_at DESC').page((params[:page] || 1))
  end

  def new
    @article = Article.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
