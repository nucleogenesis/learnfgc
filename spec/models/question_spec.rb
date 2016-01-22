require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "Validations" do
    it { should validate_presence_of :content }
  end

  describe "Associations" do
    it { should belong_to :article }    
    it { should belong_to :user }
    it { should have_many :question_comments }
  end
end
