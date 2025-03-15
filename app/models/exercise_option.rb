class ExerciseOption < ApplicationRecord
  positioned on: :exercise_group, column: :priority

  belongs_to :exercise_group

  has_many :exercise_choices

  # validates :description, :reps, presence: true
  # validates :reps, numericality: true
end
