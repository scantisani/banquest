require_relative '../../lib/game/main.rb'

# The controller for games.
class RunsController < ApplicationController
  def new
    @run = Run.new
  end

  def create
    @user = User.find(params[:user_id])
    @run = @user.runs.create

    @game = Main.new
    @run.save_data = @game.save_game
    @run.save

    redirect_to user_run_path(@user, @run)
  end

  def show
    @run = Run.find(params[:id])
  end

  def update
    @run = Run.find(params[:id])

    @game = Main.new
    @game.load_game(@run.save_data)

    @run.update(
        map: @game.keypress(params[:keypress]),
        save_data: @game.save_game)
    @run.save

    respond_to do |format|
      format.html
      format.json { render json: @run }
    end
  end
end
