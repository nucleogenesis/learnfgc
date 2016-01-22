class CreateRevisionComments < ActiveRecord::Migration
  def change
    create_table :revision_comments do |t|
      t.belongs_to :revision, index: true, foreign_key: true
      t.text :content
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
