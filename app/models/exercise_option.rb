class ExerciseOption < ApplicationRecord
  belongs_to :exercise_group

  positioned on: :exercise_group, column: :priority

  # validates :description, :reps, presence: true
  # validates :reps, numericality: true
end
