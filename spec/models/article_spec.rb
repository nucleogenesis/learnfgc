require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Validations" do
    let(:article) { build(:article) }

    describe ":title" do
      it { should validate_presence_of :title }
      it { should validate_length_of(:title).is_at_least(5) }
    end

    describe ":content" do
      it { should validate_presence_of :content }
    end

    describe ":user_id" do
      it { should validate_presence_of :user_id }
    end

    describe ":slug" do
      it "should reject invalid slugs" do
        article.slug = "foo-bar-baz-"
        expect(article).not_to be_valid
      end
    end

    describe "Creating the slug" do
      it "should produce a slug from the title" do
        article.save!
        expect(article.slug).not_to be_nil
      end
    end
  end

  describe "Associations" do
    it { should belong_to :user }
    it { should belong_to :game }
    it { should belong_to :character }
    it { should have_many :tags }
    it { should have_many :taggings }
  end
end
