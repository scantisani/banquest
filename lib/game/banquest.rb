require_relative 'map'
require_relative 'player'
require 'yaml'

# The main game loop
class Banquest
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
    print @map.draw + "\n"
  end

  def save
    save_data = { player_x: @player.x, player_y: @player.y }
    save_data.to_yaml
  end

  def load(data)
    load_data = YAML.load(data)
    @player.x = load_data[:player_x]
    @player.y = load_data[:player_y]
  end
end
