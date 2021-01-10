class AddMoreExercises < ActiveRecord::Migration[6.1]
  def up
    Exercise.create(name: 'Overhead Dumbbell Tricep Extension', exercise_type: 'total_weight', url: 'https://www.youtube.com/watch?v=X-iV-cG8cYs')
    Exercise.create(name: 'Bench Press', exercise_type: 'total_weight', url: 'https://www.youtube.com/watch?v=Y_7aHqXeCfQ')
    Exercise.create(name: 'Chin Ups', exercise_type: 'count', url: 'https://www.youtube.com/watch?v=T78xCiw_R6g')
  end

  def down
    Exercise.find(name: 'Overhead Dumbbell Tricep Extension').destroy
    Exercise.find(name: 'Bench Press').destroy
    Exercise.find(name: 'Chin Ups').destroy
  end
end
