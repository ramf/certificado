require 'rails_helper'

RSpec.describe User, type: :model do
 it "should have a factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:role_id) }
  end

  context "Associations" do
    it { should have_many(:agreements) }
  end

  pending ".role_ids_i18n"

  context "Roles" do
    describe "Admin Role" do
      it "should return true if admin" do
        user = FactoryGirl.create(:user, role_id: User.role_ids['admin'])
        expect(user.admin?).to be_truthy
      end

      it "should return false if other or none role" do
  user = FactoryGirl.create(:user, role_id: nil)
  expect(user.admin?).to be_falsey
  end
end

  describe "User Role" do
      it "should return true if user" do
        user = FactoryGirl.create(:user, role_id: User.role_ids['user'])
        expect(user.user?).to be_truthy
      endrole_id
end

      it "should return false if other or none role" do
        user = FactoryGirl.create(:user, role_id: nil)
        expect(user.user?).to be_falsey
      end
    end
  end

  context "Enums" do
    describe "role_id" do
      it "should correspond to those values" do
        expect(User.role_ids).to eq({
          "admin" => 1,
          "user"  => 2
        })
      end
    end
  end
end
