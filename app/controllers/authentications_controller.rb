class AuthenticationsController < ApplicationController
  skip_before_action :require_session
  before_action :skip_authentication, if: :signed_in?

  def new
  end

  def create
    if honeypot?
      redirect_to authentication_path
      return
    end

    user = User.find_or_create_by!(authentication_params)
    token = user.generate_token_for :authentication

    AuthenticationMailer.with(user:, token:).challenge_email.deliver_later

    redirect_to authentication_path
  end

  def show
  end

  private def skip_authentication
    redirect_to root_path
  end

  private def authentication_params
    params.expect(authentication: [ :email ])
  end

  private def honeypot?
    params[:name].present?
  end
end
