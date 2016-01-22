require 'rails_helper'

RSpec.describe QuestionComment, type: :model do
  describe "Validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :question_id }
  end

  describe "Associations" do
    it { should belong_to :question }
    it { should belong_to :user }
  end
end
