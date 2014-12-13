require_relative 'populated_map'
require_relative 'player'
require 'json'

# The main game loop
class Main
  def initialize(seed = Random.rand(9999))
    @seed = seed
    @map = PopulatedMap.new(@seed)
    @player = Player.new(@map)
  end

  def keypress(key)
    directions = { h: :west, j: :south, k: :north, l: :east,
                   y: :northwest, u: :northeast, b: :southwest,
                   n: :southeast }

    direction = directions[key.to_sym]
    @player.move(direction) if direction

    @map.redraw
    @map.to_html
  end

  def save_game
    data = { player_x: @player.x, player_y: @player.y, seed: @seed,
             seen_squares: @map.save_seen }
    data.to_json
  end

  def load_game(data)
    loaded_data = JSON.parse(data)
    @seed = loaded_data['seed']
    @map = PopulatedMap.new(@seed)
    @map.load_seen(loaded_data['seen_squares'])
    @player = Player.new(@map)
    @player.x = loaded_data['player_x']
    @player.y = loaded_data['player_y']
  end
end
