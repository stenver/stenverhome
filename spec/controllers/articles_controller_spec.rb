require 'spec_helper'

describe ArticlesController do

  describe "GET 'index'" do
    it "renders correct page" do
      get :index
      expect(response).to be_success
      expect(response).to be_success
      response.should render_template :index
    end

    describe "has articles" do
      let(:user) { FactoryGirl.create(:user) }
      before { 30.times{ FactoryGirl.create(:article, user: user) } }

      it "populates articles array" do
        get :index
        assigns(:articles).should eq(Article.paginate(page: nil, per_page: 5))
      end
    end
  end

  describe "GET 'show'" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @article = FactoryGirl.create(:article, user: user)
      30.times{ FactoryGirl.create(:comment, article: @article, user: user) }
    end

    it "renders correct page" do
      get :show, id: @article.id
      expect(response).to be_success
      response.should render_template :show
    end

    it "returns article with comments" do
      get :show, id: @article.id
      assigns(:article).should eq(@article)
      assigns(:comments).should eq(@article.comments)
    end
  end

  describe "GET 'new'" do
    it "returns correct page" do
      get :new
      expect(response).to_not be_success
      response.should redirect_to '/signin'
    end

    describe "as non admin" do
      let(:user) { FactoryGirl.create(:user) }
      before{ sign_in user, no_capybara: true }

      it "redirects to root" do
        get :new
        response.should redirect_to(root_url)
      end
    end

    describe "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before{ sign_in admin, no_capybara: true }

      it "returns the correct page" do
        get :new
        response.should render_template :new
      end
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      #get 'create'
      #expect(response).to be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      #get 'destroy'
      #expect(response).to be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      #get 'edit'
      #expect(response).to be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      #get 'update'
      #expect(response).to be_success
    end
  end

end
