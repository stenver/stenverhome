require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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

	describe "redirect_back_or(default)" do
		pending "find out whats wrong"
	#	describe "without stored location" do
	#		expect(helper.redirect_back_or("/")).to redirect_to(user_path(root_url))
	#	end
#
#		describe "with stored location" do
#			before do
#				helper.request.path = users_path
#				helper.store_location
#			end
#			it do 
#				expect(helper.redirect_back_or(user_path(@user))).to redirect_to(users_url)
#				helper.session[:return_to].should eq(nil)	
#			end
#		end
	end

	describe "store_location" do

		before do
			helper.request.path = users_path
			helper.store_location
		end
		it { helper.session[:return_to].should eq(users_url) }
	end
end
