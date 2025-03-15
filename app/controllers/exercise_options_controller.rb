class ExerciseOptionsController < ApplicationController
  def new
  end

  def create
    exercise_group = current_user.exercise_groups.find(params[:exercise_group_id])
    exercise_option = exercise_group.exercise_options.build(exercise_option_params)

    if exercise_option.save
      redirect_back fallback_location: training_sessions_path
    else
      raise exercise_option.errors.inspect
    end
  end

  private def exercise_option_params
    params.expect(exercise_option: %i[description reps])
  end
end
