require 'spec_helper'

describe "Edit page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "for non-signed-in users" do
    describe "visiting the edit page" do
      before { visit edit_user_path(user) }
      it { should have_title('Stenver Jerkku | Sign In') }
    end

    describe "after sign in has friendly forwarding" do
      before do
        visit edit_user_path(user)
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it { should have_title("Stenver Jerkku | Edit " + user.name) }
    end
  end

  describe "as wrong user" do
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
    before { sign_in user }

    describe "trying to access other users edit page" do
      before { visit edit_user_path(wrong_user) }
      it { should have_title("Stenver Jerkku | News") }
    end
  end

  describe "for correct signed in users" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it "should have valid content" do
      should have_content("Update your profile")
      should have_title("Stenver Jerkku | Edit " + user.name)
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "test"
        fill_in "Email", with: "test@test.ee"
        fill_in "Password", with: "secret"
        fill_in "Confirmation", with: "secret"
        click_button "Save changes"
      end
      it { should have_content("test") }
      it { should have_title("Stenver Jerkku | test") }
    end
  end
end
