class User < ApplicationRecord
  has_many :exercise_groups
  has_many :exercise_options, through: :exercise_groups
  has_many :exercise_choices, through: :exercise_options
  has_many :training_sessions
end
