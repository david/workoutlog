class TrainingSessionsController < ApplicationController
  def index
    redirect_to training_session_path(I18n.l(Date.today, format: :ymd))
  end

  def show
    if current_training_session.today?
      if current_user.exercises.exists?
        redirect_to training_session_exercise_path(
          current_training_session,
          current_user.exercises.first
        )
      else
        redirect_to new_training_session_exercise_path(current_training_session)
      end
    else
      render locals: {
        exercise_choices: current_training_session.exercise_choices.includes(:exercise_option),
        exercises: current_user.exercises,
        training_session: current_training_session
      }
    end
  end
end
