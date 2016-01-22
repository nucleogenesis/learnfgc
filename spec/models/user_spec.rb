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
  end

  describe "Associations" do
    it { should have_many :articles }
  end
end
