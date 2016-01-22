require 'rails_helper'

RSpec.describe Slug, type: :model do
  describe ".slugify" do
    context "Given a simple title" do
      it "Should produce a valid slug" do
        slug = Slug.slugify("Simple Title")

        expect(Slug.is_valid?(slug)).to eq(true)
        expect(slug).to eq("simple-title")
      end
    end

    context "Given a complicated title" do
      it "Should produce a valid slug given symbols inside" do
        slug = Slug.slugify("Titled For 98% Foo-Bar-Baz")

        expect(Slug.is_valid?(slug)).to eq(true)
        expect(slug).to eq("titled-for-98-foo-bar-baz")
      end
      it "Should produce a valid slug given multiple dashes in the title" do
        slug = Slug.slugify("Foo--Bar--Baz - The FooBarBaz Story")

        expect(Slug.is_valid?(slug)).to eq(true)
        expect(slug).to eq("foo-bar-baz-the-foobarbaz-story")
      end
      it "Should produce a valid slug given lots of symbols and ending with symbols" do
        slug = Slug.slugify("MathFoo: Foo%/Bar%=Baz%!")

        expect(Slug.is_valid?(slug)).to eq(true)
        expect(slug).to eq("mathfoo-foo-bar-baz")
      end
    end
  end
end
