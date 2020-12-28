def update_player player, exercises
  return unless exercises
  player.update({ pushups: exercises.pushups, squats: exercises.squats, planks: exercises.planks })
end

namespace :fight do
  task start: [:environment] do
    jacob = User.find(1)
    chief = User.find(2)
    yesterday = Date.today - 1.day
    j_exercise = DailyExercise.find_by(user_id: 1, date: yesterday)
    c_exercise = DailyExercise.find_by(user_id: 2, date: yesterday)

    player1 = Fight.default_vars
    player1[:name] = Jacob
    player2 = Fight.default_vars
    player2[:name] = 'Chief'

    update_player player1, j_exercise
    update_player player2, c_exercise

    sim = Fight.new(player1, player2)
    output = sim.fight
    full_output = "<html><body>#{output.join('<br>')}</body></html>"
    FightMailer.fight_email(jacob, chief, full_output).deliver_now
  end
end
