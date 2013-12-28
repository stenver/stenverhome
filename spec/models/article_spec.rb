require 'spec_helper'

describe Article do
	let(:user) { FactoryGirl.create(:user) }
  before do
    @article = FactoryGirl.create(:article, user: user)
  end

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:text) }
  it { should respond_to(:user_id) }
  it { should respond_to(:comments) }

  describe "when user_id is not present" do
    before { @article.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank text" do
  	before { @article.text = " "}
  	it { should_not be_valid }
  end

  describe "with blank title" do
  	before { @article.title = " "}
  	it { should_not be_valid }
  end
end
