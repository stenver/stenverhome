require 'spec_helper'

describe UsersController do

  let(:user) { FactoryGirl.create(:user) }

  describe "with authentication" do
    before { sign_in user, no_capybara: true }

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get :edit, id: user.id
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      it "returns http success" do
        put :update, id: user.id, user: user.as_json
        expect(response).to be_success
      end

      describe "forbidden attributes" do
        let(:params) do
          { user: { admin: true, password: user.password,
                    password_confirmation: user.password } }
        end
        before do
          sign_in user, no_capybara: true
          patch :update, id: user.id, user: params
        end
        it { expect(user.reload).not_to be_admin }
      end
    end

    describe "DESTROY 'destroy'" do
      before do
        @user_to_delete = FactoryGirl.create(:user) 
        @user_to_delete.save
      end

      describe "for non admin users" do
        it "should fail to delete" do
          expect { delete :destroy, id: @user_to_delete.id }.not_to change(User, :count).by(1)
        end
      end

      describe "for admin users" do
        before do 
          user.toggle(:admin) 
          user.save
        end
        it "should delete user" do
          expect { delete :destroy, id: @user_to_delete.id }.to change(User, :count).by(-1)
        end
      end
    end
  end

  describe "without authentication" do

    describe "GET 'show'" do
      it "returns http success" do
        get :show, id: user.id
        expect(response).to be_success
      end
    end
    
    describe "GET 'new'" do
      it "returns http success" do
        get :new
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        post :create, user: user.as_json
        expect(response).to be_success
      end
    end
  end
end
