# The controller for games.
class GamesController < ApplicationController
  def new
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(keypress: params[:keypress])
    @game.save
    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end

  private

  def game_params
    params.require(:game).permit(:keypress, :map)
  end
end
