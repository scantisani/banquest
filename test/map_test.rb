require 'test/unit'
require_relative '../lib/game/map.rb'

# Unit tests for map.rb
class MapTest < Test::Unit::TestCase
  def test_draw
    # will need changing later--blank map format will be different
    map = Map.new(Player.new(5, 5))
    expected_map = ''
    5.times { expected_map += '..........<br>' }
    expected_map += '.....@....<br>'
    4.times { expected_map += '..........<br>' }
    assert_equal(expected_map, map.draw)
  end
end
