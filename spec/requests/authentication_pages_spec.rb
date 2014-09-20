require 'spec_helper'

describe "Authentication" do
  subject {page}
  
  describe "Visit signin page" do
    before { visit signin_path }
    
    describe "with login information" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
    end
    it { should have_title(user.name) }
    it { should have_selector('div.alert.alert-error') }
    it { should have_link('Profile',     href: user_path(user)) }
    it { should have_link('Sign out',    href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }
  end
  
end
