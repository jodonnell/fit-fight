class CreateFighter < ActiveRecord::Migration[6.1]
  def change
    create_table :fighters do |t|
      t.integer :hp
      t.integer :wins
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
