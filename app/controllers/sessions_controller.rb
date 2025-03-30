class SessionsController < ApplicationController
  skip_before_action :require_session

  def create
    user = User.find_by_token_for(:authentication, params[:token])

    sign_in user if user

    redirect_to root_path
  end

  private def sign_in(user)
    session[:user_id] = user.id
  end
end
