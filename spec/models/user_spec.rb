require 'rails_helper'

describe User do
  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:authenticate) }

  it "has an encrypted password" do
    user = User.create!(:username => "testUser", :password => "password")
    expect(user.password_digest).not_to be_nil
  end

  describe "username" do
    it "is unique" do
      user1 = User.new(:username => "testUser", :password => "password")
      user2 = User.new(:username => "testUser", :password => "password")

      user1.save

      expect(user2).not_to be_valid
    end
  end
end
