require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    describe ":username" do
      before { create(:user) }
      let(:invalid_username_case) { build(:user, email: 'unique@emmail.com', username: 'eXamPLe') }

      it { should validate_presence_of :username }
      it { should validate_length_of(:username).is_at_least(4) }

      it "Should validate uniqueness case-sensitively" do
        expect {invalid_username_case.save!}.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe ":email" do
      before { create(:user) }
      let(:invalid_user_case) { build(:user, email: "EXAMPLE@EMAIL.COM", username: 'unique') }
      let(:invalid_user_format) { build(:user, email: "foo.bar.email.com", username: 'unique') }
      let(:valid_user) { build(:user, email: "foo.bar@email.com", username: 'unique') }

      it { should validate_presence_of :email }

      it "Should validate case-sensitive uniqueness" do
        expect{invalid_user_case.save!}.to raise_error ActiveRecord::RecordInvalid
      end

      it "Should validate format of emails" do
        expect{invalid_user_format.save!}.to raise_error ActiveRecord::RecordInvalid
      end

      it "Should (naturally) accept unique emails" do
        expect{valid_user.save!}.not_to raise_error
      end
    end

    describe ":roles, #verify_role_format" do
      let(:user) { build(:user) }

      context "when given a sentence with spaces between the commas" do
        it "strips the whitespace and creates a valid string" do
          user.roles = "Street Fighter V, Another Game , And One More"
          user.save
          expect(user.roles).to eq("Street Fighter V,Another Game,And One More")
        end

        it "doesn't get all screwy if there are no commas" do
          user.roles = "BlazBlue: Chronophantasma EX"
          user.save
          expect(user.roles).to eq("BlazBlue: Chronophantasma EX")
        end
      end
    end
  end

  describe "Associations" do
    it { should have_many :articles }
  end

  describe "Instance Methods" do
    let(:user) { build_stubbed(:user) }

    describe "#has_role?" do
      it "returns false if nil" do
        user.roles = nil
        expect(user.has_role?(nil)).to eq(false)
      end
      it "checks to see if the user has a role" do
        expect(user.has_role?("Street Fighter IV")).to eq(true)
        expect(user.has_role?("Tekken 7")).to eq(true)
        expect(user.has_role?("Street Fighter V")).to eq(true)
        expect(user.has_role?("Street Fighter III")).to eq(false)
        expect(user.has_role?("Admin")).to eq(false)
      end
    end
  end
end
