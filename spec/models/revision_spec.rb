require 'rails_helper'

RSpec.describe Revision, type: :model do
  describe "Validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :title }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :article_id }
  end

  describe "Associations" do 
    it { should belong_to :article }
    it { should belong_to :user }
    it { should have_many :revision_comments }
  end
end
