class WelcomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @exercises = Exercise.all

    @todays_exercises = DailyExercise.get_user_and_day current_user['id'], Date.today
    @values = Exercise.empty_hash

    @todays_exercises.exercise_counts.each do |count|
      @values[count.exercise.name] = count.count
    end
  end

  def update
    todays_exercises = DailyExercise.find_by(user_id: current_user['id'], date: Date.today)
    ExerciseCount.where(daily_exercise_id: todays_exercises.id).delete_all

    param_names = params.keys.filter {|key| key.starts_with? 'exercise_'}
    results = param_names.map do |param_key|
      id = param_key.split('_')[1].to_i
      count = params[param_key]

      ExerciseCount.new(exercise_id: id, count: count)
    end

    todays_exercises.exercise_counts = results
    redirect_to :root
  end

  def simulate_form
    @exercises = Exercise.all

    @player1_values = {}
    @player2_values = {}
    param_names = params.keys.filter {|key| key.starts_with? 'exercise_'}
    results = param_names.map do |param_key|
      id = param_key.split('_')[1].to_i
      count = params[param_key].to_i

      if param_key.split('_')[2] == '1'
        @player1_values[exercise_by_id[id].name] = count
      else
        @player2_values[exercise_by_id[id].name] = count
      end
    end
  end

  def simulate
    @exercise_by_id = exercise_by_id

    total_sims = 1000
    player1_wins = 0
    player2_wins = 0

    total_sims.times do |x|
      player1 = Fight.default_vars
      player1[:name] = 'Jacob'
      player2 = Fight.default_vars
      player2[:name] = 'Chief'

      update_player player1, '1'
      update_player player2, '2'

      sim = Fight.new(player1, player2)
      sim.fight
      if player1[:wins]
        player1_wins += 1
      elsif player2[:wins]
        player2_wins += 1
      end
    end

    player1_percent = player1_wins / total_sims.to_f
    player2_percent = player2_wins / total_sims.to_f

    if player1_percent > player2_percent
      flash.alert = "Jacob wins #{player1_percent * 100}% of the time"
    else
      flash.alert = "Chief wins #{player2_percent * 100}% of the time"
    end
    redirect_to simulate_path(request.params)
  end

  private
  def update_player player, player_num
    param_names = params.keys.filter {|key| key.starts_with? 'exercise_'}
    results = param_names.map do |param_key|
      id = param_key.split('_')[1].to_i
      if param_key.split('_')[2] == player_num
        count = params[param_key]
        player[:exercises][@exercise_by_id[id].name] = count.to_i
      end
    end
  end

  def exercise_by_id
    exercises = Exercise.all
    exercise_by_id = {}
    exercises.each do |exercise|
      exercise_by_id[exercise.id] = exercise
    end
    exercise_by_id
  end

end
