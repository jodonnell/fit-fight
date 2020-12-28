class WelcomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    todays_exercises = DailyExercise.find_by(user_id: current_user['id'], date: Date.today)
    @pushups = 0
    @squats = 0
    @planks = 0
    if todays_exercises
      @pushups = todays_exercises.pushups
      @squats = todays_exercises.squats
      @planks = todays_exercises.planks
    end
  end

  def update
    todays_exercises = DailyExercise.find_by(user_id: current_user['id'], date: Date.today)
    if todays_exercises
      todays_exercises.pushups = params['pushups'].to_i
      todays_exercises.squats = params['squats'].to_i
      todays_exercises.planks = params['planks'].to_i
      todays_exercises.save
    else
      todays_exercises = DailyExercise.new(
        user_id: current_user['id'],
        date: Date.today,
        pushups: params['pushups'].to_i,
        squats: params['squats'].to_i,
        planks: params['planks'].to_i,
      )
      todays_exercises.save
    end
    redirect_to :root
  end
end
