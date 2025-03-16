class AuthenticationMailer < ApplicationMailer
  def challenge_email
    @user = params[:user]
    @token = params[:token]

    mail(to: @user.email, subject: I18n.t(".login_confirmation"))
  end
end
