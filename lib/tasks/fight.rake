namespace :fight do
  task start: [:environment] do
    jacob = User.find(1)
    chief = User.find(2)
    yesterday = Date.today - 1.day
    j_exercise = DailyExercise.find_by(user_id: 1, date: yesterday)
    c_exercise = DailyExercise.find_by(user_id: 2, date: yesterday)

    player1 = { min_damage: 5, max_damage: 10, min_block: 0, max_block: 5, pushups: 0, squats: 0, name: 'Jacob', hp: 40 }
    player2 = { min_damage: 5, max_damage: 10, min_block: 0, max_block: 5, pushups: 0, squats: 0, name: 'Chief', hp: 40 }

    if j_exercise
      player1.update({ pushups: j_exercise.pushups, squats: j_exercise.squats })
    end

    if c_exercise
      player2.update({ pushups: c_exercise.pushups, squats: c_exercise.squats })
    end

    sim = Fight.new(player1, player2)
    output = sim.fight
    full_output = "<html><body>#{output.join('<br>')}</body></html>"
    FightMailer.fight_email(jacob, chief, full_output).deliver_now
  end
end
