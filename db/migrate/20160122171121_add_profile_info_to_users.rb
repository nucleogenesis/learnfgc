class AddProfileInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xbox_live_username, :string
    add_column :users, :psn_username, :string
    add_column :users, :steam_username, :string
    add_column :users, :twitter, :string
    add_column :users, :twitch, :string
    add_column :users, :youtube, :string
  end
end
