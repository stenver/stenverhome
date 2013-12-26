require 'spec_helper'

describe "Index users" do
  subject { page } 
  let(:user) { FactoryGirl.create(:user) }

  describe "for non-signed-in users" do
    describe "visiting the edit page" do
      before { visit users_path }
      it { should have_title('Stenver Jerkku | Sign In') }
    end

    describe "after sign in has friendly forwarding" do
      before do
        visit users_path(user)
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it { should have_title("Stenver Jerkku | All users") }
    end
  end

  describe "for signed in user" do
    before do
      sign_in user
      30.times { FactoryGirl.create(:user) } 
      visit users_path
    end
    
    it { should have_title("Stenver Jerkku | All users") }
    it { should have_selector('div.pagination') }
    it "should list each user" do
      User.paginate(page: 1).each do |u|
        expect(page).to have_selector('li', text: u.name)
      end
    end

    describe "delete links" do
      it { should_not have_link("delete") }

      describe "as an admin user" do
        before do
          user.admin = true
          user.save
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.where.not(id: user.id).first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(user)) }
      end
    end
  end
end
