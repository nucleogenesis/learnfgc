require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "Validations" do
    describe ":name" do
      before { create(:tag) }
      let(:tag) { build(:tag, name: "mYsTRING") }

      it { should validate_presence_of :name }
      it { should validate_length_of(:name).is_at_least(3) }
      it "Should Validate Uniqueness of Tags" do
        expect { tag.save! }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  describe "Associations" do
    it { should have_many :taggings }
    it { should have_many :articles }
  end
end
