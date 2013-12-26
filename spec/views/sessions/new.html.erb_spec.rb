require 'spec_helper'

describe "Sign in page" do
  subject { page }
  before { visit signin_path }

  it "is correct page" do
  	should have_content("Sign In") 	
  end

  describe "with invalid information" do
  	before { click_button "Sign in" }
  	it { should have_title('Stenver Jerkku | Sign In')}
  	it { should have_selector('div.alert.alert-error') }
  end

  describe "with valid information" do
  	before do
  		@user = FactoryGirl.create(:user)
      @user.save
  		fill_in "Email", with: @user.email
  		fill_in "Password", with: @user.password
	  	click_button "Sign in" 
  	end
    it { should_not have_selector('div.alert.alert-error') }
  	it { should have_title("Stenver Jerkku | " + @user.name)}

    describe "followed by signout" do
      before do
        click_link "Sign out" 
      end
      it { should_not have_link("Sign out")}
    end
  end
end
