require 'test/unit'
require_relative '../lib/game/square.rb'
require_relative '../lib/game/wall.rb'
require_relative '../lib/game/floor.rb'
require_relative '../lib/game/player.rb'

# Unit tests for square.rb, wall.rb, floor.rb
class SquaresTest < Test::Unit::TestCase
  def test_square_seen
    unseen_square = Square.new
    seen_square = Square.new
    seen_square.mark_seen
    assert_equal(unseen_square.symbol, seen_square.symbol)
    assert_equal(' ', unseen_square.symbol)
  end

  def test_wall_seen
    unseen_wall = Wall.new
    seen_wall = Wall.new
    seen_wall.mark_seen
    assert_not_equal(unseen_wall.symbol, seen_wall.symbol)
    assert_equal(' ', unseen_wall.symbol)
    assert_equal('#', seen_wall.symbol)
  end

  def test_floor_seen
    unseen_floor = Floor.new
    seen_floor = Floor.new
    seen_floor.mark_seen
    assert_not_equal(unseen_floor.symbol, seen_floor.symbol)
    assert_equal(' ', unseen_floor.symbol)
    assert_equal('.', seen_floor.symbol)
  end

  def test_occupy_visible
    unoccupied_floor = Floor.new
    occupied_floor = Floor.new
    player = Player.new
    occupied_floor.occupy(player)
    assert_not_equal(unoccupied_floor.symbol, occupied_floor.symbol)
    assert_equal(player.symbol, occupied_floor.symbol)
  end

  def test_occupy_leave
    seen_floor = Floor.new
    occupied_floor = Floor.new
    player = Player.new
    occupied_floor.occupy(player)
    occupied_floor.occupy(nil)
    seen_floor.mark_seen
    assert_equal(seen_floor.symbol, occupied_floor.symbol)
  end
end
