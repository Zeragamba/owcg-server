class ApplicationController < ActionController::API
  def current_user
    if !@current_user
      if request.headers['Authorization'].present?
        auth_token = request.headers['Authorization'].split(' ').last
        data = AuthToken.decode(auth_token)
        @current_user = User.find_by_username(data.dig("user", "username"))
      else
        @current_user = nil
      end
    end

    return @current_user
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    if !logged_in?
      render :json => {
        error: "Not Authorized"
      }, :status => :unauthorized
    end
  end
end
