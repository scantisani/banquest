require 'test/unit'
require 'json'
require_relative '../lib/game/main.rb'

# Unit tests for main.rb
class MainTest < Test::Unit::TestCase
  def test_save_load
    seed = Random.rand(9999)
    clean_game = Main.new(seed)
    reloaded_game = Main.new(seed)
    reloaded_game.load_game(reloaded_game.save_game)
    assert_equal(clean_game.keypress('j'), reloaded_game.keypress('j'))
  end

  def test_seeded_map
    seed = Random.rand(9999)
    game = Main.new(seed)
    player = Player.new

    # hacky
    data = JSON.parse(game.save_game)
    player.x = data['player_x']
    player.y = data['player_y']

    map = PopulatedMap.new(player, seed)
    assert_equal(game.keypress(' '), map.to_html)
  end
end
