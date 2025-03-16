class User < ApplicationRecord
  has_many :exercise_groups
  has_many :exercise_options, through: :exercise_groups
  has_many :exercise_choices, through: :exercise_options
  has_many :training_sessions

  generates_token_for :authentication, expires_in: 5.minutes

  validates :email, presence: true, uniqueness: true
end
