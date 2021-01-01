def update_player player, exercises
  return unless exercises
  exercises.exercise_counts.each do |count|
    player[:exercises][count.exercise.name] = count.count
  end
end

namespace :fight do
  task start: [:environment] do
    jacob = User.find(1)
    chief = User.find(2)
    yesterday = Date.today - 1.day
    j_exercise = DailyExercise.get_user_and_day 1, yesterday
    c_exercise = DailyExercise.get_user_and_day 2, yesterday

    player1 = Fight.default_vars
    player1[:name] = 'Jacob'
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
