require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  let(:game) { create(:game) }
  let(:character) { create(:character, game_id: game.id) }

  describe "#show" do
    it "assigns the character to @character" do
      get :show, game_id: game.id, id: character.slug

      expect(assigns(:character).name).to eq(character.name)
      expect(assigns(:character).history).to eq(character.history)
      expect(assigns(:character).slug).to eq(character.slug)
    end
    it "assigns the character's game to @game" do
      get :show, game_id: game.id, id: character.slug

      expect(assigns(:game).id).to eq(character.game_id)
      expect(assigns(:game).title).to eq(character.game.title)
    end
    it "assigns a page of articles to @articles" do
      other_character = create(:character, game_id: game.id)
      user = build_stubbed(:user)
      20.times { create(:random_article, user_id: user.id, game_id: game.id, character_id: character.id) }
      20.times { create(:random_article, user_id: user.id, game_id: game.id, character_id: other_character.id) }

      get :show, game_id: game.id, id: character.slug

      expect(assigns(:articles).length).to eq(Article.default_per_page)
      assigns(:articles).each do |a|
        expect(a.character_id).to eq(character.id)
      end

      get :show, game_id: game.id, id: other_character.slug

      expect(assigns(:articles).length).to eq(Article.default_per_page)
      assigns(:articles).each do |a|
        expect(a.character_id).to eq(other_character.id)
      end
    end
  end
  describe "#frame_data" do
    it "assigns the character to @character"
    it "assigns the character's frame data to @frame_data"
  end
  describe "#combos" do
    it "assigns the character to @character"
    it "assigns the character's combos to @combos"
  end
end
