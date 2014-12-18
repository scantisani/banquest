require 'test/unit'
require_relative '../lib/game/monsters/monster.rb'
require_relative '../lib/game/populated_map.rb'

# Unit tests for monster.rb
class TestMonster < Test::Unit::TestCase
  def setup
    @map = PopulatedMap.new(Random.rand(9999))
    @control = Monster.new(@map)
  end

  def test_approach
    approacher = Monster.new(@map)

    distance_before = euclidean_distance(
      @control.x, @control.y, approacher.x, approacher.y)
    approacher.approach(@control)
    distance_after = euclidean_distance(
      @control.x, @control.y, approacher.x, approacher.y)

    assert(distance_after <= distance_before)
  end

  def euclidean_distance(x0, y0, x1, y1)
    Math.sqrt((x1 - x0)**2 + (y1 - y0)**2)
  end
end
