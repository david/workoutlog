class ExerciseOptionsController < ApplicationController
  def new
    exercise = current_user.exercises.find(params[:exercise_id])

    render locals: {
      exercise:,
      exercise_option: exercise.exercise_options.build,
      training_session: current_training_session
    }
  end

  def create
    exercise = current_user.exercises.find(params[:exercise_id])
    exercise_option = exercise.exercise_options.build(exercise_option_params)

    if exercise_option.save
      redirect_to training_session_exercise_path(current_training_session, exercise)
    else
      raise exercise_option.errors.inspect
    end
  end

  private def exercise_option_params
    params.require(:exercise_option).permit(:description, :name, :reps)
  end
end
