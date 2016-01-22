class AddFieldsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :title, :string
    add_column :questions, :content, :text
    add_column :questions, :user_id, :integer
    add_column :questions, :article_id, :integer
  end
end
