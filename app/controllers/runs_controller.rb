require_relative '../../lib/game/main.rb'

# The controller for games.
class RunsController < ApplicationController
  def new
    @run = Run.new
  end

  def create
    @run = Run.new
    @game = Main.new
    @run.save_data = @game.save_game
    @run.save

    redirect_to @run
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

  private

  def game_params
    params.require(:run).permit(:keypress, :save_data)
  end
end
