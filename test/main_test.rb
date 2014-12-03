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

  def test_h_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('west')
    assert_equal(game.keypress('h'), map.draw)
  end

  def test_j_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('south')
    assert_equal(game.keypress('j'), map.draw)
  end

  def test_k_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('north')
    assert_equal(game.keypress('k'), map.draw)
  end

  def test_l_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('east')
    assert_equal(game.keypress('l'), map.draw)
  end

  def test_y_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('northwest')
    assert_equal(game.keypress('y'), map.draw)
  end

  def test_u_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('northeast')
    assert_equal(game.keypress('u'), map.draw)
  end

  def test_b_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('southwest')
    assert_equal(game.keypress('b'), map.draw)
  end

  def test_n_keypress
    game = Main.new
    player = Player.new
    map = Map.new(player)

    player.move('southeast')
    assert_equal(game.keypress('n'), map.draw)
  end
end
