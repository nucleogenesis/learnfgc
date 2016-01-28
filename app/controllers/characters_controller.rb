class CharactersController < ApplicationController
  def show
    @character = Character.find_by_slug(params[:id])
    @game = @character.game
    @articles = Article.where(character_id: @character.id).order('created_at DESC').page((params[:page] || 1))
  end

  def frame_data
    @character = Character.find_by_slug(params[:id])
    @game = @character.game
    @articles = Article.order('created_at DESC').page((params[:page] || 1))
  end

  def combos
    @character = Character.find_by_slug(params[:id])
    @game = @character.game
    @articles = Article.order('created_at DESC').page((params[:page] || 1))
  end
end
