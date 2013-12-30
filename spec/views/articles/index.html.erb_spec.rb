require 'spec_helper'

describe "articles/index.html.erb" do
  subject { page }

  it "should have have title 'Stenver Jerkku | News'" do
    visit root_url
    expect(page).to have_title('Stenver Jerkku | News')
  end

  describe "with articles and comments" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      60.times{ FactoryGirl.create(:article, user: user) }
      60.times{ FactoryGirl.create(:comment, user: user, article: Article.first) }
      visit root_url
    end

    it { should have_selector('div.pagination') }

    it "should have articles and comments" do
      Article.paginate(page: nil, per_page: 5).each do |a|
        should have_content( a.title)
      end
    end
  end
end
