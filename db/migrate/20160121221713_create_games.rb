class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :abbr
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
  end
end
