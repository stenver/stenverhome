require 'spec_helper'

describe "Signup page" do

  subject { page }

  before { visit signup_path }

  it "should be the right page" do
  	should have_content('Sign Up') 
  	should have_title('Sign up')
  end

  it "It should succeed with valid data" do
  	fill_in "Name", with: "test"
  	fill_in "Email", with: "test@test.ee"
  	fill_in "Password", with: "secret"
  	fill_in "Confirmation", with: "secret"
  	expect { click_button "Create my account" }.to change(User, :count).by(1)
  end

  it "should fail with no data" do
  	expect { click_button "Create my account" }.not_to change(User, :count)
  end
end