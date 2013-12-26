require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:articles) }
  it { should respond_to(:comments) }
  it { should be_valid }
  it { should_not be_admin}

  describe "Should not be valid without name" do
    before { user.name = "" }
    it { should_not be_valid }
  end

  describe "Should not be valid without email" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "Should not be valid without matching password" do
    before { user.password = "" }
    it { should_not be_valid }
    before { user.password = "1234567", user.password_confirmation = "" }
    it { should_not be_valid }
    before { user.password = "1234567", user.password_confirmation = "abcdfeg" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    describe "with valid password" do
      it { expect(user.remember_token).not_to be_blank}
      it { should eq found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to eq false }
    end
  end

  describe "Email should be uniqe" do
    it "should fail with duplicate email" do
      user.save
      dublicate = user.dup
      result = dublicate.save
      expect(result).to eq false
      end
  end

  describe "Email should become lowercase" do
    before do
      user.email = "TEST@TEST.EE"
      user.save
    end
    it { expect(user.email).to eq("test@test.ee") }
  end

  describe "with admin set to true" do
    before { user.toggle(:admin) }
    it { should be_admin }
  end
end
