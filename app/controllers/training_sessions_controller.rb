class TrainingSessionsController < ApplicationController
  def index
    redirect_to training_session_path(current_user.training_sessions.today)
  end

  def show
    if current_training_session.future?
      redirect_to training_session_path(current_user.training_sessions.today)
    elsif current_training_session.today?
      if current_user.exercises.exists?
        redirect_to training_session_exercises_path(current_training_session)
      else
        redirect_to new_training_session_exercise_path(current_training_session)
      end
    else
      redirect_to training_session_exercises_path(current_training_session)
    end
  end
end
