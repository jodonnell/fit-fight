class DropExercisesFromDailyExercises < ActiveRecord::Migration[6.1]
  def change
    remove_column :daily_exercises, :squats
    remove_column :daily_exercises, :pushups
    remove_column :daily_exercises, :planks
  end
end
