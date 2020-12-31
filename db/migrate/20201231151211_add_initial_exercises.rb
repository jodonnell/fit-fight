class AddInitialExercises < ActiveRecord::Migration[6.1]
  def up
    Exercise.create(name: 'Push Ups', exercise_type: 'count')
    Exercise.create(name: 'Squats', exercise_type: 'count')
    Exercise.create(name: 'Planks', exercise_type: 'minutes')
    Exercise.create(name: 'Running', exercise_type: 'minutes')
    Exercise.create(name: 'Rowing', exercise_type: 'minutes')

    Exercise.create(name: 'Curls', exercise_type: 'total_weight')
    Exercise.create(name: 'Shoulder Press', exercise_type: 'total_weight', url: 'https://www.youtube.com/watch?v=B-aVuyhvLHU')
  end

  def down
    Exercise.delete_all
  end
end
