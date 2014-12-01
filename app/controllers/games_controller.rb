require_relative '../../lib/game/main.rb'

# The controller for games.
class GamesController < ApplicationController
  def new
  end

  def create
  end

  def show
    @game = Game.find(params[:id])
    @banquest = Main.new
    @game.save_data = @banquest.save_game
    @game.save
  end

  def update
    @game = Game.find(params[:id])

    @banquest = Main.new
    @banquest.load_game(@game.save_data)

    @game.update(
        keypress: params[:keypress],
        map: @banquest.keypress(params[:keypress]),
        save_data: @banquest.save_game)
    @game.save

    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end

  private

  def game_params
    params.require(:game).permit(:keypress, :save_data)
  end
end
