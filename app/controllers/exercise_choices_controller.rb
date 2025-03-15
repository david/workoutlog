class ExerciseChoicesController < ApplicationController
  def create
    training_session = TrainingSession.
      find_or_create_by!(session_on: params[:training_session_session_on])

    exercise_choice_params = exercise_choice_params_for_create
    exercise_option_id = exercise_choice_params.delete(:exercise_option_id)
    exercise_option = ExerciseOption.find(exercise_option_id)

    exercise_choice = training_session.exercise_choices.
      build(exercise_option:, **exercise_choice_params)

    if exercise_choice.save
      redirect_back fallback_location: training_session
    else
      raise exercise_choice.errors.inspect
    end
  end

  def update
    if ExerciseChoice.find(params[:id]).update(exercise_choice_params_for_update)
      redirect_back fallback_location: training_sessions_path
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
