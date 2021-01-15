class Exercise < ApplicationRecord
  has_many :exercise_counts
  has_many :daily_exercise, through: :exercise_counts

  def self.empty_hash
    pluck(:name).zip([0].cycle).to_h
  end
end
