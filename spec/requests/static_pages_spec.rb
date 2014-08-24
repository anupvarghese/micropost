require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Micropost App') }
    it { should_not have_title('| Home') }
    it { should have_content('Sign up now')}
  end
  
  describe "Help page" do
    before { visit help_path }
    it { should have_content('Help') }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_content('About Us') }
  end
  
  describe "Contact page" do
    before { visit contact_path }
    it { should have_content('Contact Us') }
  end
 
  describe "Link clicks" do
    before {visit root_path}
    it "should redirect to correct page" do
      click_link "About"
      expect(page).to have_content('About Us')
      click_link "Help"
      expect(page).to have_content('Help')
      click_link "Home"
      expect(page).to have_content('Micropost App')
      click_link "Contact"
      expect(page).to have_content('Contact Us')
    end
  end
end
