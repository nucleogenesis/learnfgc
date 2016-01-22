require 'rails_helper'

RSpec.describe "Visiting Game", type: :feature do
  let!(:game) { create(:game) }
  let!(:characters) { create_list(:character, 24, game: game) }
  let!(:user) { create(:user) }
  let!(:articles) { 
    create_list(
      :random_article, 
      50, 
      user: user,
      game: game,
      character: characters.first
    ) 
  }

  feature "User visits a game index" do
    before(:each) { visit game_path(game) }

    scenario "they see a menu with each character" do
      characters.each do |char|
        expect(page).to have_text char.name
        expect(page).to have_link "Articles", href: game_character_path(game_id: game.slug, id: char.slug)
        expect(page).to have_link "Frame Data", href: frame_data_game_character_path(game_id: game.slug, id: char.slug)
        expect(page).to have_link "Combos", href: combos_game_character_path(game_id: game.slug, id: char.slug)
      end
    end
    scenario "they see a list of 10 articles" do
      expect(page.all(:css, ".article-list-item").length).to eq(10)
    end
   end
end
