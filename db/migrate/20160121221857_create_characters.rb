class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string  :name
      t.text    :history
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
