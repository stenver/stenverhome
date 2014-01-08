require 'spec_helper'

describe "articles/new.html.erb" do
  let(:user) { FactoryGirl.create(:admin) }

  describe "for signed in users" do
    before do
      sign_in user
      visit new_article_path
    end

    it { page.should have_title("Stenver Jerkku | New Article") }
  end
end
