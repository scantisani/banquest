require 'test/unit'
require_relative '../lib/game/player.rb'

# Unit tests for player.rb
class PlayerTest < Test::Unit::TestCase
  def setup
    @p = []
    14.times { @p.push(Player.new(4, 4)) }
    @control = Player.new(4, 4)
  end

  def test_square
    @p[0].move('north')
    @p[0].move('east')
    @p[0].move('south')
    @p[0].move('west')
    assert_equal([@control.x, @control.y], [@p[0].x, @p[0].y])
  end

  def test_diamond
    @p[1].move('northeast')
    @p[1].move('southeast')
    @p[1].move('southwest')
    @p[1].move('northwest')
    assert_equal([@control.x, @control.y], [@p[1].x, @p[1].y])
  end

  def test_north
    @p[2].move('north')
    assert_equal(@control.x, @p[2].x)
    assert_equal(@control.y - 1, @p[2].y)
  end

  def test_east
    @p[3].move('east')
    assert_equal(@control.x + 1, @p[3].x)
    assert_equal(@control.y, @p[3].y)
  end

  def test_south
    @p[4].move('south')
    assert_equal(@control.x, @p[4].x)
    assert_equal(@control.y + 1, @p[4].y)
  end

  def test_west
    @p[5].move('west')
    assert_equal(@control.x - 1, @p[5].x)
    assert_equal(@control.y, @p[5].y)
  end

  def test_northeast
    @p[6].move('northeast')
    @p[7].move('north')
    @p[7].move('east')
    assert_equal([@p[6].x, @p[6].y], [@p[7].x, @p[7].y])
  end

  def test_southeast
    @p[8].move('southeast')
    @p[9].move('south')
    @p[9].move('east')
    assert_equal([@p[8].x, @p[8].y], [@p[9].x, @p[9].y])
  end

  def test_southwest
    @p[10].move('southwest')
    @p[11].move('south')
    @p[11].move('west')
    assert_equal([@p[10].x, @p[10].y], [@p[11].x, @p[11].y])
  end

  def test_northwest
    @p[12].move('northwest')
    @p[13].move('north')
    @p[13].move('west')
    assert_equal([@p[12].x, @p[12].y], [@p[13].x, @p[13].y])
  end

  def test_init
    initialized_player = Player.new(5, 5)
    assert_equal(5, initialized_player.x)
    assert_equal(5, initialized_player.y)
  end
end
