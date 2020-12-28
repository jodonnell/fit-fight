class AddPlanksToDailyExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_exercises, :planks, :integer
  end
end
