require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "#show" do
    let(:user) { build_stubbed(:user) }
    let(:game) { create(:game) }
    let(:other_game) { create(:game, title: 'Super Mega Fight City 2', abbr: 'SMFC2') }
    let(:other_user) { build_stubbed(:user, username: "username", email: "username@email.com") }
    let!(:characters) { create_list(:character, 16, game_id: game.id) }
    let!(:articles) { create_list(:random_article, 20, user_id: user.id, game_id: game.id) }
    let!(:other_articles) { create_list(:random_article, 20, user_id: user.id, game_id: other_game.id) }

    it "assigns the game to @game" do
      get :show, id: game.slug

      expect(assigns(:game).title).to eq(game.title)
      expect(assigns(:game).id).to eq(game.id)
    end
    it "assigns a page of articles to @articles" do
      get :show, id: game.slug

      expect(assigns(:articles).count).to eq(Article.default_per_page)
      assigns(:articles).each do |a|
        expect(a.game_id).to eq(game.id)
      end

      get :show, id: other_game.slug

      expect(assigns(:articles).count).to eq(Article.default_per_page)
      assigns(:articles).each do |a|
        expect(a.game_id).to eq(other_game.id)
      end
    end
      
    it "assigns all of the game's characters to @characters" do
      get :show, id: game.slug
      expect(assigns(:characters).count).to eq(characters.count)
      assigns(:characters).each do |c|
        expect(characters.include?(c)).to eq(true)
      end
    end
  end
end
