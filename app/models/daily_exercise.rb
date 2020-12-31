class DailyExercise < ApplicationRecord
  belongs_to :user

  has_many :exercise_counts
  has_many :exercises, through: :exercise_counts

  def self.get_user_and_day id, day
    DailyExercise.includes(:exercise_counts, :exercises).find_by(user_id: id, date: day)
  end
end
