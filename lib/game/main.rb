require_relative 'populated_map'
require_relative 'player'
require 'yaml'

# The main game loop
class Main
  def initialize
    @player = Player.new
    @map = PopulatedMap.new(@player, Random.new.rand(9999))
  end

  def keypress(key)
    direction = { h: 'west', j: 'south', k: 'north', l: 'east',
                  y: 'northwest', u: 'northeast', b: 'southwest',
                  n: 'southeast' }

    key = key.to_sym
    @player.move(direction[key]) if direction.key?(key)
    @map.redraw
    @map.to_html
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
