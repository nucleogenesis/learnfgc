require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    describe ":email" do
      before { create(:user) }
      let(:invalid_user_case) { build(:user, email: "EXAMPLE@EMAIL.COM") }
      let(:invalid_user_format) { build(:user, email: "foo.bar.email.com") }
      let(:valid_user) { build(:user, email: "foo.bar@email.com") }

      it { should validate_presence_of :email }

      it "Should validate case-sensitive uniqueness" do
        puts User.first.email
        puts invalid_user_case.email
        expect{invalid_user_case.save!}.to raise_error ActiveRecord::RecordInvalid
      end

      it "Should validate format of emails" do
        expect{invalid_user_format.save!}.to raise_error ActiveRecord::RecordInvalid
      end

      it "Should (naturally) accept unique emails" do
        expect{valid_user.save!}.not_to raise_error
      end
    end
  end

  describe "Associations" do
    it { should have_many :articles }
  end
end
