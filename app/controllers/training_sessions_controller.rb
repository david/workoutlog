class TrainingSessionsController < ApplicationController
  def index
    redirect_to training_session_path(I18n.l(Date.today, format: :ymd))
  end

  def show
    training_session = current_user.training_sessions.
      find_or_initialize_by(session_on: params[:session_on])
    exercise_id = params[:exercise_id]

    if exercise_id.blank? && current_user.exercises.exists?
      redirect_to exercise_training_session_path(
        training_session,
        current_user.exercises.first
      )
    else
      render locals: {
        exercise_choices: training_session.exercise_choices.includes(:exercise_option),
        exercise: exercise_id.presence &&
          current_user.exercises.find_by(id: exercise_id),
        exercises: current_user.exercises.all,
        training_session:
      }
    end
  end
end
