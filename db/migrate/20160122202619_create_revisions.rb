class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.belongs_to :article, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.text :content
      t.string :title

      t.timestamps null: false
    end
  end
end
