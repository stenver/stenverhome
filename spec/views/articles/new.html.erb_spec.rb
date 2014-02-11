require 'spec_helper'

describe "articles/new.html.erb" do
  let(:user) { FactoryGirl.create(:admin) }

  describe "for signed in users" do
    before do
      sign_in user
      visit new_article_path
    end

    it { page.should have_title("Stenver Jerkku | New Article") }

    it "It should create new article with valid data" do
      fill_in "Title", with: "test_title"
      fill_in "article[text]", with: "test_text"
      expect { click_button "Create article" }.to change(Article, :count).by(1)
    end

    it "should populate article with correct data" do
      fill_in "Title", with: "test_title"
      fill_in "article[text]", with: "test_text"
      click_button "Create article"
      article = Article.last
      article.title.should eq("test_title")
      article.text.should eq("test_text")
    end
  end
end
