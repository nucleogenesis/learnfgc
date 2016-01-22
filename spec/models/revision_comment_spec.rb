require 'rails_helper'

RSpec.describe RevisionComment, type: :model do
  describe "Validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :revision_id }
  end

  describe "Associations" do 
    it { should belong_to :revision }
    it { should belong_to :user }
  end
end
