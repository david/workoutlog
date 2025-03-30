class ExerciseOption < ApplicationRecord
  belongs_to :exercise
  positioned on: :exercise, column: :priority

  has_many :exercise_choices

  # validates :description, :reps, presence: true
  # validates :reps, numericality: true
end
