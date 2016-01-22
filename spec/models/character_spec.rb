require 'rails_helper'

RSpec.describe Character, type: :model do
  describe "Validations" do
    let(:character) { create(:character) }

    describe ":name" do 
      it { should validate_presence_of :name }
    end

    describe ":history" do
      it { should validate_presence_of :history }
    end

    describe ":game_id" do
      it { should validate_presence_of :game_id }
    end

    describe ":slug" do
      it "Should have slug based on the name" do
        expect(character.slug).to eq("fighter-guy")
      end
    end
  end

  describe "Associations" do
    it { should have_many :articles }
    it { should belong_to :game }
  end
end
