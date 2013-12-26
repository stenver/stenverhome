require 'spec_helper'

describe PublicController do

  describe "GET 'blog'" do
    it "returns http success" do
      get 'blog'
      expect(response).to be_success
    end
  end

  describe "GET 'coolStuff'" do
    it "returns http success" do
      get 'coolStuff'
      expect(response).to be_success
    end
  end

  describe "GET 'experience'" do
    it "returns http success" do
      get 'experience'
      expect(response).to be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      expect(response).to be_success
    end
  end

end
