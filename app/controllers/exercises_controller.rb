class ExercisesController < ApplicationController
  def create
    exercise = current_user.exercises.new(exercise_params)

    if exercise.save
      redirect_back fallback_location: root_path
    else
      raise exercise.errors.inspect
    end
  end

  private def exercise_params
    params.require(:exercise).permit(:name)
  end
end
