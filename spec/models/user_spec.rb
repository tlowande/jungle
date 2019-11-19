require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    let(:user) {User.new(name: "Claire Loo", email: 'c@c.Com', password:'1234', password_confirmation: '1234')}

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "must be created with a password and password_confirmation fields" do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end

    it "should have password and password_confirmation fields matching" do
      expect(user.password).to eq(user.password_confirmation)
    end
    
    it "must have unique emails" do
      user.save
      expect(User.where(email: user.email).count).to be(1)
      @user2 = User.create(name: "Claire Loo", email: 'c@c.Com', password:'1234', password_confirmation: '1234')
      expect(User.where(email: user.email).count).not_to be(2)
    end

    it "emails can not be case sensitive" do
      user.save
      @user3 = User.create(name: "Claire Loo", email: 'C@C.Com', password:'1234', password_confirmation: '1234')
      expect(User.where(email: @user3.email).count).to be(0)
    end

    it "must have a password minimum length of 4 character" do
      user.password = '123'
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) {User.create(name: "Claire Loo", email: 'c@c.Com', password:'1234', password_confirmation: '1234')}
    
    it "should validate user" do
      # user1 = User.create(name: "Claire Loo", email: 'c@c.Com', password:'1234', password_confirmation: '1234')
      @user = User.authenticate_with_credentials(user.email, user.password)
      
      expect(@user).not_to be_nil

    end

    it "should return nil if password doesn't match" do
      @user = User.authenticate_with_credentials(user.email, '12345')
      expect(@user).to be_nil

    end

    it "should return nil if user doesn't exist" do
      @user = User.authenticate_with_credentials('a@c.Com', user.password)
      expect(@user).to be_nil
    end

    it "should authenticate the user if there's a wrong case in the email" do
      @user = User.authenticate_with_credentials('C@C.Com', user.password)
      expect(@user).not_to be_nil
    end

    it "should authenticate the user if there's blank space before and after the email" do
      @user = User.authenticate_with_credentials(' C@C.Com ', user.password)
      expect(@user).not_to be_nil
    end


  end
end
