Rails.application.routes.draw do
  post "/login", to: "login#login"

  scope "/users" do
    post "/", to: "user#create"

    get "/me", to: "user#view"
    patch "/me", to: "user#update"
    delete "/me", to: "user#destroy"
  end
end
