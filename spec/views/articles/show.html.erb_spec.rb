require 'spec_helper'

describe "articles/show.html.erb" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:article) { FactoryGirl.create(:article, user: user) }
  before { visit article_path(article) }

  it "should have have correct title" do
    expect(page).to have_title('Stenver Jerkku | ' + article.title)
  end

  it { should have_content(article.text) }
end
