class ExerciseCount < ApplicationRecord
  belongs_to :daily_exercise
  belongs_to :exercise
end
