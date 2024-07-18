
def update_player player, exercises
  return unless exercises
  player[:exercises] = Exercise.empty_hash

  exercises.exercise_counts.each do |count|
    player[:exercises][count.exercise.name] = count.count
  end
end

namespace :fight do
  task start: [:environment] do

    Game.all.each do |game|

      user1 = User.find(game.user1_id)
      user2 = User.find(game.user2_id)
      fighter1 = Fighter.find(game.fighter1_id)
      fighter2 = Fighter.find(game.fighter2_id)

      yesterday = Date.today - 1.day
      j_exercise = DailyExercise.get_user_and_day 1, yesterday
      c_exercise = DailyExercise.get_user_and_day 2, yesterday

      player1 = Fight.default_vars
      player1[:name] = user1.name
      player1[:hp] = fighter1.hp
      player1[:fighter] = fighter1

      player2 = Fight.default_vars
      player2[:name] = user2.name
      player2[:hp] = fighter2.hp
      player2[:fighter] = fighter2

      update_player player1, j_exercise
      update_player player2, c_exercise

      sim = Fight.new(player1, player2)
      output = sim.fight

      full_output = "<html><body>#{output.join('<br>')}</body></html>"
      FightMailer.fight_email(user1, user2, full_output).deliver_now
      #puts full_output
    end
  end
end
