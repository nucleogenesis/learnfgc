require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Validations" do
    before { create(:article) }
    let(:article) { create(:article, user: User.first) }

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
        expect(article.valid?).not_to eq(true)
      end

      it "should append a numerical timestamp to a non-unique slug" do
        # May fail if run precisely as the day changes...
        expect(article.slug).to match(Time.now.to_formatted_s(:number)[0..7])
      end
    end

    describe "Creating the slug" do
      it "should produce a slug from the title" do
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
    it { should have_many :questions }
  end

  describe "Instance Methods" do
    describe "#author" do
      let(:article) { build_stubbed(:article) } # Factory creates User
      it "Should return the name of the user" do
        subject {article}
        expect(article.author).to eq(article.user.username)
      end
    end
  end
end
