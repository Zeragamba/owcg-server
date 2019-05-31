describe UserController do
  describe "POST /users" do
    let(:params) { {
      :user => {
        :username => "username",
        :password => "password",
      }
    } }

    it "returns http success" do
      post "/users", :params => params
      expect(response).to have_http_status(:success)
    end

    it "creates a user" do
      expect { post "/users", :params => params }.to change { User.count }.by(1)
    end
  end

  describe "GET /users/me" do
    it "requires a logged in user" do
      get "/users/me"
      expect(response).to have_http_status(:unauthorized)
    end

    context "when a user is logged in" do
      let(:user) { User.create!(:username => "username", :password => "password") }
      let(:headers) { { "Authorization" => "token #{AuthToken.for_user(user)}" } }

      it "returns http success" do
        get "/users/me", :headers => headers
        expect(response).to have_http_status(:success)
      end

      it "data on the current user" do
        get "/users/me", :headers => headers

        body = JSON.parse(response.body)
        expect(body["user"]).to eq(user.as_json)
      end
    end
  end

  describe "PATCH /users/me" do
    let(:params) { {
      :user => {
        :username => "new_name",
        :password => "new_pass",
      }
    } }

    it "requires a logged in user" do
      patch "/users/me", :params => params
      expect(response).to have_http_status(:unauthorized)
    end

    context "when a user is logged in" do
      let(:user) { User.create!(:username => "username", :password => "password") }
      let(:headers) { { "Authorization" => "token #{AuthToken.for_user(user)}" } }

      it "returns http success" do
        patch "/users/me", :params => params, :headers => headers
        expect(response).to have_http_status(:success)
      end

      it "update the user's username" do
        patch "/users/me", :params => params, :headers => headers

        user.reload
        expect(user.username).to eq("new_name")
      end

      it "update the user's password" do
        patch "/users/me", :params => params, :headers => headers

        user.reload
        expect(user.authenticate("new_pass")).to be_truthy
      end
    end
  end

  describe "DELETE /users/me" do
    it "requires a logged in user" do
      delete "/users/me"
      expect(response).to have_http_status(:unauthorized)
    end

    context "when a user is logged in" do
      let!(:user) { User.create!(:username => "username", :password => "password") }
      let(:headers) { { "Authorization" => "token #{AuthToken.for_user(user)}" } }

      it "returns http success" do
        delete "/users/me", :headers => headers

        expect(response).to have_http_status(:success)
      end

      it "deletes the current user" do
        delete "/users/me", :headers => headers

        expect(User.find_by_id(user.id)).to be_nil
      end
    end
  end
end
