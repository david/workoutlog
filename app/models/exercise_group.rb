class ExerciseGroup < ApplicationRecord
  has_many :exercise_options, dependent: :destroy
end
