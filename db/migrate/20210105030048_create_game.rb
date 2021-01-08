class CreateGame < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :user1, null: false, foreign_key: { to_table: :users }
      t.references :user2, null: false, foreign_key: { to_table: :users }
      t.references :fighter1, null: false, foreign_key: { to_table: :fighters }
      t.references :fighter2, null: false, foreign_key: { to_table: :fighters }

      t.timestamps
    end
  end
end
