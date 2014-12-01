require 'test/unit'
require_relative '../lib/game/player.rb'

# Unit tests for player.rb
class PlayerTest < Test::Unit::TestCase
  def setup
    @p = []
    13.times { @p.push(Player.new(4, 4)) }
  end

  def test_return
    @p[0].move('north')
    @p[0].move('east')
    @p[0].move('south')
    @p[0].move('west')
    assert_equal(4, @p[0].x)
    assert_equal(4, @p[0].y)
  end

  def test_north
    @p[1].move('north')
    assert_equal(4, @p[1].x)
    assert_equal(3, @p[1].y)
  end

  def test_east
    @p[2].move('east')
    assert_equal(5, @p[2].x)
    assert_equal(4, @p[2].y)
  end

  def test_south
    @p[3].move('south')
    assert_equal(4, @p[3].x)
    assert_equal(5, @p[3].y)
  end

  def test_west
    @p[4].move('west')
    assert_equal(3, @p[4].x)
    assert_equal(4, @p[4].y)
  end

  def test_northeast
    @p[5].move('northeast')
    @p[6].move('north')
    @p[6].move('east')
    assert_equal(@p[5].x, @p[6].x)
    assert_equal(@p[5].y, @p[6].y)
    assert_equal(5, @p[5].x)
    assert_equal(3, @p[5].y)
  end

  def test_southeast
    @p[7].move('southeast')
    @p[8].move('south')
    @p[8].move('east')
    assert_equal(@p[7].x, @p[8].x)
    assert_equal(@p[7].y, @p[8].y)
    assert_equal(5, @p[7].x)
    assert_equal(5, @p[7].y)
  end

  def test_southwest
    @p[9].move('southwest')
    @p[10].move('south')
    @p[10].move('west')
    assert_equal(@p[9].x, @p[10].x)
    assert_equal(@p[9].y, @p[10].y)
    assert_equal(3, @p[9].x)
    assert_equal(5, @p[9].y)
  end

  def test_northwest
    @p[11].move('northwest')
    @p[12].move('north')
    @p[12].move('west')
    assert_equal(@p[11].x, @p[12].x)
    assert_equal(@p[11].y, @p[12].y)
    assert_equal(3, @p[11].x)
    assert_equal(3, @p[11].y)
  end

  def test_init
    @initialized_player = Player.new(5, 5)
    assert_equal(5, @initialized_player.x)
    assert_equal(5, @initialized_player.y)
  end
end
