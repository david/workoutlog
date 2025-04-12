class ExercisesController < ApplicationController
  def create
    exercise = current_user.exercises.new(exercise_params)

    if exercise.save
      redirect_to exercise_path(exercise)
    else
      raise exercise.errors.inspect
    end
  end

  def index
    training_session = todays_training_session

    render locals: {
      exercises: current_user.exercises,
      training_session:
    }
  end

  def new
    render locals: {
      exercise: current_user.exercises.build
    }
  end

  def show
    # Use current_training_session if accessed via dated route, otherwise today's
    training_session = params[:training_session_session_on] ? current_training_session : todays_training_session
    exercise = current_user.exercises.find(params[:id])

    render locals: {
      exercise: exercise,
      exercises: current_user.exercises,
      training_session: training_session
    }
  end

  private def exercise_params
    params.require(:exercise).permit(:name)
  end
end
