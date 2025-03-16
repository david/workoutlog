class TrainingSessionsController < ApplicationController
  def index
    redirect_to training_session_path(I18n.l(Date.today, format: :ymd))
  end

  def show
    training_session = current_user.training_sessions.
      find_or_initialize_by(session_on: params[:session_on])
    exercise_group_id = params[:exercise_group_id]

    if exercise_group_id.blank? && current_user.exercise_groups.exists?
      redirect_to exercise_group_training_session_path(
        training_session,
        current_user.exercise_groups.first
      )
    else
      render locals: {
        exercise_choices: training_session.exercise_choices.includes(:exercise_option),
        exercise_group: exercise_group_id.presence &&
          current_user.exercise_groups.find_by(id: exercise_group_id),
        exercise_groups: current_user.exercise_groups.all,
        training_session:
      }
    end
  end
end
