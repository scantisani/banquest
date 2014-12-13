require 'test/unit'
require_relative '../lib/game/actor.rb'
require_relative '../lib/game/populated_map.rb'

# Unit tests for actor.rb
class ActorTest < Test::Unit::TestCase
  def setup
    map = PopulatedMap.new(Random.rand(9999))
    @control = Actor.new(map, 4, 4)
    @a = []
    14.times { @a.push(@control.clone) }
  end

  def test_square
    @a[0].move(:north)
    @a[0].move(:east)
    @a[0].move(:south)
    @a[0].move(:west)
    assert_equal([@control.x, @control.y], [@a[0].x, @a[0].y])
  end

  def test_diamond
    @a[1].move(:northeast)
    @a[1].move(:southeast)
    @a[1].move(:southwest)
    @a[1].move(:northwest)
    assert_equal([@control.x, @control.y], [@a[1].x, @a[1].y])
  end

  def test_north
    @a[2].move(:north)
    assert_equal(@control.x, @a[2].x)
    assert_equal(@control.y - 1, @a[2].y)
  end

  def test_east
    @a[3].move(:east)
    assert_equal(@control.x + 1, @a[3].x)
    assert_equal(@control.y, @a[3].y)
  end

  def test_south
    @a[4].move(:south)
    assert_equal(@control.x, @a[4].x)
    assert_equal(@control.y + 1, @a[4].y)
  end

  def test_west
    @a[5].move(:west)
    assert_equal(@control.x - 1, @a[5].x)
    assert_equal(@control.y, @a[5].y)
  end

  def test_northeast
    @a[6].move(:northeast)
    @a[7].move(:north)
    @a[7].move(:east)
    assert_equal([@a[6].x, @a[6].y], [@a[7].x, @a[7].y])
  end

  def test_southeast
    @a[8].move(:southeast)
    @a[9].move(:south)
    @a[9].move(:east)
    assert_equal([@a[8].x, @a[8].y], [@a[9].x, @a[9].y])
  end

  def test_southwest
    @a[10].move(:southwest)
    @a[11].move(:south)
    @a[11].move(:west)
    assert_equal([@a[10].x, @a[10].y], [@a[11].x, @a[11].y])
  end

  def test_northwest
    @a[12].move(:northwest)
    @a[13].move(:north)
    @a[13].move(:west)
    assert_equal([@a[12].x, @a[12].y], [@a[13].x, @a[13].y])
  end

  def test_init
    initialized_actor = Actor.new(PopulatedMap.new(Random.rand(9999)), 5, 5)
    assert_equal(5, initialized_actor.x)
    assert_equal(5, initialized_actor.y)
  end

  def test_next_to
    adjacent_actors = Array.new(8) { @control.clone }
    adjacent_actors[0].move(:east)
    adjacent_actors[1].move(:west)
    adjacent_actors[2].move(:south)
    adjacent_actors[3].move(:north)
    adjacent_actors[4].move(:northeast)
    adjacent_actors[5].move(:northwest)
    adjacent_actors[6].move(:southeast)
    adjacent_actors[7].move(:southwest)

    adjacent_actors.each do |actor|
      assert(actor.next_to(@control))
    end
  end
end