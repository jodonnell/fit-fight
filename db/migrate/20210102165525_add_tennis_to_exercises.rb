class AddTennisToExercises < ActiveRecord::Migration[6.1]
  def up
    Exercise.create(name: 'Tennis', exercise_type: 'minutes')
  end

  def down
    Exercise.find(name: 'Tennis').destroy
  end
end
