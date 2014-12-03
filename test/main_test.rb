require 'test/unit'
require_relative '../lib/game/main.rb'

# Unit tests for main.rb
class MainTest < Test::Unit::TestCase
  def test_save_load
    clean_game = Main.new
    reloaded_game = Main.new
    reloaded_game.load_game(reloaded_game.save_game)
    assert_equal(clean_game.keypress('j'), reloaded_game.keypress('j'))
  end
end
