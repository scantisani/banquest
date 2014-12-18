require 'test/unit'
require_relative '../lib/game/floor.rb'
require_relative '../lib/game/coin.rb'
require_relative '../lib/game/player.rb'
require_relative '../lib/game/populated_map.rb'

# Unit tests for floor.rb
class TestFloor < Test::Unit::TestCase
  def setup
    @control = Floor.new
  end

  def test_symbol_display
    # checks that players are displayed over items
    occupied = @control.clone
    occupied.seen = true
    assert_equal('.', occupied.symbol)

    occupied.item = Coin.new(42)
    assert_equal('*', occupied.symbol)

    occupied.occupant = Player.new(PopulatedMap.new(1234))
    assert_equal('@', occupied.symbol)

    occupied.item = nil
    assert_equal('@', occupied.symbol)

    occupied.occupant = nil
    assert_equal('.', occupied.symbol)
  end

  def test_seen_if_occupied_by_player
    floor = @control.clone
    assert_equal(' ', floor.symbol)
    floor.occupy(Player.new(PopulatedMap.new(1234)))
    assert(floor.seen == true)
  end

  def test_occupied
    floor = @control.clone
    floor.occupy(Player.new(PopulatedMap.new(1234)))
    assert(floor.occupied?)
    floor.occupant = nil
    assert(!floor.occupied?)
  end
end
