class GamesController < ApplicationController
  def show
    @articles = Article.order('created_at DESC').page((params[:page] || 1))
  end
end
