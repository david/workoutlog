class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_session

  private def current_training_session
    @current_training_session ||= current_user.training_sessions.find_or_initialize_by(
      session_on: params[:session_on] || params[:training_session_session_on]
    )
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  private def require_session
    redirect_to new_authentication_path unless signed_in?
  end

  private def signed_in?
    current_user.present?
  end
end
