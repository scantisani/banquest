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
    direction = { h: 'west', j: 'south', k: 'north', l: 'east',
                      y: 'northwest', u: 'northeast', b: 'southwest',
                      n: 'southeast' }

    key = key.to_sym
    if direction.key?(key) then @player.move(direction[key]) end
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
