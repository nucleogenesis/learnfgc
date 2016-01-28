class GamesController < ApplicationController
  def show
    @game = Game.find_by_slug(params[:id])
    @articles = Article.where(game_id: @game).order('created_at DESC').page((params[:page] || 1))
    @characters = @game.characters
  end
end
