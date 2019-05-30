require 'rails_helper'

describe LoginController do
  describe "post /login" do
    context "when the username and password are valid" do
      let(:user) {User.create!(:username => "username", :password => "password")}

      before do
        post "/login", :params => {
          :username => user.username,
          :password => user.password,
        }
      end

      it "responds 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns an access token" do
        body = JSON.parse(response.body)
        expect(body["auth_token"]).to eq(AuthToken.encode({
          user: {
            username: user.username
          }
        }))
      end
    end
  end
end