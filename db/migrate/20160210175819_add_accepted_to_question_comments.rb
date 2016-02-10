class AddAcceptedToQuestionComments < ActiveRecord::Migration
  def change
    add_column :question_comments, :accepted, :boolean, default: false
  end
end
