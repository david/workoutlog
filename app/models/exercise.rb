class Exercise < ApplicationRecord
  has_many :exercise_options, dependent: :destroy

  def find_or_initialize_choices_for(training_session)
    return [] if exercise_options.empty?

    choices = training_session.exercise_choices.
      where(exercise_option_id: exercise_options.map(&:id))

    exercise_options.map { |exercise_option|
      choices.find { |c| c.exercise_option_id == exercise_option.id } ||
        training_session.exercise_choices.build(exercise_option:)
    }
  end
end
