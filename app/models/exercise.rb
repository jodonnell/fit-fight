class Exercise < ApplicationRecord
  has_many :exercise_counts
  has_many :daily_exercise, through: :exercise_counts

  def self.empty_hash
    exercises = all
    result = {}
    exercises.each do |exercise|
      result[exercise.name] = 0
    end
    result
  end
end
