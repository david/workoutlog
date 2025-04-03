class ExerciseOptionsController < ApplicationController
  def new
  end

  def create
    exercise = current_user.exercises.find(params[:exercise_id])
    exercise_option = exercise.exercise_options.build(exercise_option_params)

    if exercise_option.save
      redirect_back fallback_location: training_sessions_path
    else
      raise exercise_option.errors.inspect
    end
  end

  private def exercise_option_params
    params.expect(exercise_option: %i[description name reps])
  end
end
