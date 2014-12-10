# The player.
class Player
  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @symbol = '@'
  end

  def move(direction)
    compass = {
      north: [0, -1], east: [1, 0], south: [0, 1], west: [-1, 0],
      northeast: [1, -1], southeast: [1, 1], southwest: [-1, 1],
      northwest: [-1, -1]
    }

    @x += compass[direction][0] # x-axis movement
    @y += compass[direction][1] # y-axis movement
  end

  attr_accessor :x
  attr_accessor :y
  attr_reader :symbol
end
