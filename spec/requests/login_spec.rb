describe LoginController do
  describe "post /login" do
    context "when the username and password are valid" do
      let(:user) { User.create!(:username => "username", :password => "password") }
      let(:params) { {
        :username => user.username,
        :password => user.password,
      } }

      it "responds 200" do
        post "/login", :params => params

        expect(response).to have_http_status(:ok)
      end

      it "returns an access token" do
        post "/login", :params => params

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