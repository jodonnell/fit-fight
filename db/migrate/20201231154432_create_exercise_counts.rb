class CreateExerciseCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_counts do |t|
      t.belongs_to :daily_exercise
      t.belongs_to :exercise

      t.integer :count

      t.timestamps
    end
  end
end
