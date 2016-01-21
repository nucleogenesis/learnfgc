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

    describe ":slug" do
      it "should reject invalid slugs" do
        article.slug = "foo-bar-baz-"
        expect(article).not_to be_valid
      end
    end

    describe "Creating the slug" do
      it "should produce a slug from the title" do
        article.save!
      end
    end
  end


  describe ".slugify" do
    let(:article) { build(:article) }

    context "Given a simple title" do
      it "Should produce a valid slug" do
        article.title = "A Simple Title"
        article.valid?

        expect(article.slug).to eq("a-simple-title")
      end
    end

    context "Given a complicated title" do
      it "Should produce a valid slug given symbols inside" do
        article.title = "Titled For 98% Foo-Bar-Baz"
        article.valid?

        expect(article.slug).to eq("titled-for-98-foo-bar-baz")
      end
      it "Should produce a valid slug given multiple dashes in the title" do
        article.title = "Foo--Bar--Baz - The FooBarBaz Story"
        article.valid?

        expect(article.slug).to eq("foo-bar-baz-the-foobarbaz-story")
      end
      it "Should produce a valid slug given lots of symbols and ending with symbols" do
        article.title = "MathFoo: Foo%/Bar%=Baz%!"
        article.valid?

        expect(article.slug).to eq("mathfoo-foo-bar-baz")
      end
    end
  end
end