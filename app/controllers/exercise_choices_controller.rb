class ExerciseChoicesController < ApplicationController
  def create
    training_session = todays_training_session

    exercise_choice_params = exercise_choice_params_for_create
    exercise_option_id = exercise_choice_params.delete(:exercise_option_id)
    exercise_option = current_user.exercise_options.find(exercise_option_id)

    exercise_choice = training_session.exercise_choices.
      build(exercise_option:, **exercise_choice_params)

    if exercise_choice.save
      redirect_to exercise_path(exercise_option.exercise_id)
    else
      raise exercise_choice.errors.inspect
    end
  end

  def update
    exercise_choice = current_user.exercise_choices.include(:exercise_option).find(params[:id])

    if exercise_choice.update(exercise_choice_params_for_update)
      redirect_to exercise_path(exercise_choice.exercise_option.exercise_id)
    else
      raise exercise_choice.errors.inspect
    end
  end

  private def exercise_choice_params_for_create
    params.expect(exercise_choice: [ :exercise_option_id, :reps ])
  end

  private def exercise_choice_params_for_update
    params.expect(exercise_choice: [ :reps ])
  end
end
