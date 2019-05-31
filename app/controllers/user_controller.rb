class UserController < ApplicationController
  before_action :require_login, :only => [
    :update, :view, :destroy
  ]

  def create
    user = User.new(user_params)

    if user.save
      render json: {
        msg: "success",
        user: user,
      }, status: 201
    else
      render json: {
        errors: user.errors,
      }, status: 400
    end
  end

  def view
    if current_user
      render json: {
        user: current_user
      }
    end
  end

  def update
    current_user.update(user_params)

    if current_user.save
      render json: {
        msg: "success",
        user: current_user,
      }, status: 200
    else
      render json: {
        errors: current_user.errors,
      }, status: 400
    end
  end

  def destroy
    current_user.destroy!

    render json: {
      msg: "success",
      user: current_user,
    }, status: 200
  end

  private

  def user_params
    params.require(:user).permit([
      :username,
      :password,
    ])
  end
end
