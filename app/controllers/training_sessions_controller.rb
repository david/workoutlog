class TrainingSessionsController < ApplicationController
  def index
    redirect_to training_session_path(I18n.l(Date.today, format: :ymd))
  end

  def create
  end

  def show
    training_session = current_user.training_sessions.from_date_string(params[:session_on])

    if params[:exercise_group_id]
      render locals: {
        exercise_choices: training_session.exercise_choices.includes(:exercise_option),
        exercise_group: current_user.exercise_groups.find(params[:exercise_group_id]),
        exercise_groups: current_user.exercise_groups.all,
        training_session:
      }
    else
      redirect_to exercise_group_training_session_path(
        training_session,
        current_user.exercise_groups.first
      )
    end
  end
end
