require_relative 'map'
require_relative 'player'
require 'yaml'

# The main game loop
class Main
  def initialize
    @player = Player.new
    @map = Map.new(@player)
  end

  def keypress(key)
    case key
    when 'h'
      @player.move('west')
    when 'j'
      @player.move('south')
    when 'k'
      @player.move('north')
    when 'l'
      @player.move('east')
    end
    @map.draw
  end

  def save_game
    data = { player_x: @player.x, player_y: @player.y }
    data.to_yaml
  end

  def load_game(data)
    loaded_data = YAML.load(data)
    @player.x = loaded_data[:player_x]
    @player.y = loaded_data[:player_y]
  end
end
