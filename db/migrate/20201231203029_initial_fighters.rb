class InitialFighters < ActiveRecord::Migration[6.1]
  def up
    Fighter.create(user_id: 1, hp: 40, wins: 0)
    Fighter.create(user_id: 2, hp: 40, wins: 0)
  end

  def down
    Fighter.delete_all
  end
end
