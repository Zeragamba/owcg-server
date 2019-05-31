class LoginController < ApplicationController
  def login
    user = User
      .find_by_username(params[:username])
      .try(:authenticate, params[:password])

    if !user
      return render json: { error: "invalid login" }, :status => 400
    end

    payload = {
      :msg => "success",
      :auth_token => AuthToken.for_user(user),
    }

    render json: payload, :status => 200
  end
end
