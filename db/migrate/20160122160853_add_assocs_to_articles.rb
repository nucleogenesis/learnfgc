class AddAssocsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :game_id, :integer
    add_column :articles, :character_id, :integer
  end
end
