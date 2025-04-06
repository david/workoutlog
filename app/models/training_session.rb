class TrainingSession < ApplicationRecord
  belongs_to :user
  has_many :exercise_choices

  delegate :past?, :future?, :today?, to: :session_on

  def self.today
    find_or_initialize_by(session_on: Date.today)
  end

  def previous
    self.class.find_or_initialize_by(session_on: session_on - 1)
  end

  def next
    self.class.find_or_initialize_by(session_on: session_on + 1)
  end

  def to_param
    I18n.l(session_on, format: :ymd)
  end
end
