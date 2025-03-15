class ExerciseChoice < ApplicationRecord
  belongs_to :exercise_option

  delegate :description, :priority, to: :exercise_option
end
