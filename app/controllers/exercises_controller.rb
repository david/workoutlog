class ExercisesController < ApplicationController
  before_action :redirect_if_future_session

  def create
    exercise = current_user.exercises.new(exercise_params)

    if exercise.save
      redirect_to [ current_training_session, exercise ]
    else
      raise exercise.errors.inspect
    end
  end

  def new
    render locals: { exercises: current_user.exercises }
  end

  def show
    render locals: {
      exercise: current_user.exercises.find(params[:id]),
      exercises: current_user.exercises,
      training_session: current_training_session
    }
  end

  private def exercise_params
    params.require(:exercise).permit(:name)
  end

  private def redirect_if_future_session
    if current_training_session.future?
      redirect_to training_session_path(current_user.training_sessions.today)
    end
  end
end
