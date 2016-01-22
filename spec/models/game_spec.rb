require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Validations" do
    let(:game) { build(:game) }

    describe ":title" do
      it { should validate_presence_of :title }
    end

    describe ":slug" do
      it "should reject invalid slugs" do
        game.slug = "foo-bar-baz-"
        expect(game).not_to be_valid
      end
    end

    describe "Creating the slug" do
      it "should produce a slug from the title" do
        game.save!
        expect(game.slug).not_to be_nil
      end
    end
  end

end
