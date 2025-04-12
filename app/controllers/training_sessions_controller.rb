class TrainingSessionsController < ApplicationController
  def index
    redirect_to exercises_path
  end

  def show
    training_session = current_training_session

    if training_session.past?
      render locals: { training_session: }
    else
      redirect_to exercises_path
    end
  end
end
