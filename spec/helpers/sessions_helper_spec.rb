require 'spec_helper'

describe SessionsHelper do
	before do
		@user = FactoryGirl.create(:user)
		@user.save
	end

	describe "Sign_in" do
		before { helper.sign_in(@user) }
		it "should sign the user in" do
			cookies.permanent[:remember_token].should_not be_empty
			token = cookies.permanent[:remember_token]
			@user.remember_token.should eq(User.encrypt(token))
			helper.current_user.id.should eq(@user.id)

		end
	end

	describe "Sign_out" do
		before do
			helper.sign_in(@user)
			@old_token = @user.remember_token
			helper.sign_out
		end

		it "should sign the user out" do
			@user.remember_token.should_not eq(@old_token)
			cookies.permanent[:remember_token].should eq(nil)
			helper.current_user.should eq(nil)
		end
	end

	describe "Signed_in?" do
		describe "for signed out users" do
			it { helper.signed_in?.should eq(false)}
		end

		describe "for signed in users " do
			before { helper.sign_in(@user) }
			it { helper.signed_in?.should eq(true)}
		end
	end

	describe "current_user= "do
		before { helper.current_user=(@user) }
		it { helper.current_user.id.should eq(@user.id) }
	end

	describe "current_user" do

		describe "for signed out users" do
			it { helper.current_user.should eq(nil) }
		end

		describe "for signed in users " do
			before { helper.sign_in(@user) }
			it "should return current user" do
			 helper.current_user.id.should eq(@user.id)
			 helper.current_user.remember_token.should eq(User.encrypt(cookies[:remember_token]))
			end
		end
	end

	describe "current_user?" do
		before { helper.sign_in(@user) }

		describe "with same user" do
			it { helper.current_user?(@user).should eq(true) }
		end

		describe "with different user" do
			let(:other_user) { FactoryGirl.create(:user) }
			it { helper.current_user?(other_user).should eq(false) }
		end
	end

	describe "store_location" do

		before do
			helper.request.path = users_path
			helper.store_location
		end
		it { helper.session[:return_to].should eq(users_url) }
	end
end
