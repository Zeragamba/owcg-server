require 'rails_helper'

describe User do
  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:authenticate) }

  it "has an encrypted password" do
    user = User.create!(:username => "testUser", :password => "password")
    expect(user.password_digest).not_to be_nil
  end
end
