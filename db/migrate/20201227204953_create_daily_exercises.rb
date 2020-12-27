class CreateDailyExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_exercises do |t|
      t.date :date
      t.integer :pushups
      t.integer :squats
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
