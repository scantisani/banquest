require 'test/unit'
require_relative '../lib/game/main.rb'

# Unit tests for main.rb
class TestMain < Test::Unit::TestCase
  def test_save_load
    seed = Random.rand(9999)
    clean_game = Main.new(seed)
    reloaded_game = Main.new(seed)
    reloaded_game.load_game(reloaded_game.save_game)
    assert_equal(clean_game.keypress(' '), reloaded_game.keypress(' '))
  end
end
