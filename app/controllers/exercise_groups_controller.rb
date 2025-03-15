class ExerciseGroupsController < ApplicationController
  def create
    exercise_group = current_user.exercise_groups.new(exercise_group_params)

    if exercise_group.save
      redirect_back fallback_location: training_sessions_path
    else
      raise exercise_group.errors.inspect
    end
  end

  private def exercise_group_params
    params.expect(exercise_group: [ :name ])
  end
end
