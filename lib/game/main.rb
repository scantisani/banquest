require_relative 'populated_map'
require_relative 'player'
require_relative 'monster_generator'
require_relative 'display'
require 'json'
require 'active_support/core_ext/hash' # to deal with JSON parsing--see below

# The main game loop
class Main
  def initialize(seed = Random.rand(9999))
    @seed = seed
    @map = PopulatedMap.new(@seed)
    @player = Player.new(@map)
    @monsters = MonsterGenerator.new(@map, 3).monsters
    @display = Display.new(@map)
  end

  def keypress(key)
    directions = { h: :west, j: :south, k: :north, l: :east,
                   y: :northwest, u: :northeast, b: :southwest,
                   n: :southeast }

    direction = directions[key.to_sym]
    @player.move(direction) if direction

    @monsters.each(&:take_turn)

    @display.redraw
    @display.to_html
  end

  def save_game
    data = { player_data: @player.save_data, seed: @seed,
             monster_data: @monsters.map(&:save_data),
             seen_squares: @map.save_seen }
    data.to_json
  end

  def load_game(data)
    data = JSON.parse(data).deep_symbolize_keys! # JSON-parsed keys are strings
    @seed = data[:seed]
    @map = PopulatedMap.new(@seed, data[:seen_squares])
    @player = Player.new(@map, data[:player_data])

    @monsters = data[:monster_data].map { |datum| FruitBat.new(@map, datum) }
    @monsters.each { |monster| @map.add_actor(monster) }

    @display = Display.new(@map)
  end
end
