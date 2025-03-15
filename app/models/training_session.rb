class TrainingSession < ApplicationRecord
  has_many :exercise_choices

  delegate :past?, to: :session_on

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
