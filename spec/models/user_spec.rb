require 'spec_helper'

describe User do
  before { @user = User.new(:name => 'Anoop', :email => 'anupvarghese@outlook.com',
    :password =>'mypassword', :password_confirmation =>'mypassword')}
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:remember_token)}
  
  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a"*60 }
    it { should_not be_valid }
  end
  
  describe "when name is too small" do
    before { @user.name = "a" }
    it { should_not be_valid }
  end
  
  describe "when email id is same for 2 users" do
    before do
      @newuser = @user.dup
      @newuser.save
    end
    it { should_not be_valid }
  end
  
  describe "when email id is same for 2 users but with different case" do
    before do
      @newuser = @user.dup
      @newuser.email = @user.email.upcase
      @newuser.save
    end
    it { should_not be_valid }
  end
  
  describe "email saving" do
    before do 
      @user.email = @user.email.upcase
      @user.save
    end
    it "has the email id downcase converted before saving" do
      @user.reload.email.should eq @user.email.downcase
    end
  end
  
  describe "when psasword is too short" do
    before do
      @user.password = @user.password_confirmation = "a"*5
    end
    it { should_not be_valid }
  end
  
  describe "with invalid password" do
    before do
      @user.save
    end    
    let(:fetched_user) { User.find_by(email: @user.email) }
    it "should not be valid" do
      expect(fetched_user.name) == @user.name
    end
   
  end
  
  describe "when password is invalid" do
    before do
      @user.save
    end    
    let(:fetched_user) { @user.authenticate("wrongpassword") }
    it { should_not eq fetched_user }
    specify { expect(fetched_user).to be_false }
  end
  
  describe "remember token" do
    before do
      @user.save
    end
    its(:remember_token){ should_not be_blank }
  end
end
