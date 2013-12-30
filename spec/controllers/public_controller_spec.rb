require 'spec_helper'

describe PublicController do

  describe "GET 'coolStuff'" do
    it "renders correct page" do
      get :coolStuff
      expect(response).to be_success
      response.should render_template :coolStuff
    end
  end

  describe "GET 'about'" do
    it "renders correct page" do
      get :about
      expect(response).to be_success
      response.should render_template :about
    end
  end

end
