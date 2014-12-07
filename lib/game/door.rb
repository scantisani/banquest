# Doors connecting rooms in the dungeon.
class Door
  def initialize(room_length, room_width, seed)
    @generator = Random.new(seed)
    @room_width = room_width
    @room_length = room_length
    place
  end

  def place
    # generates coordinates of doors
    # arrays start at 0, so we need -1 for last value, -2 for 2nd-last value
    if either(true, false)
      # east or west walls
      @x = either(0, @room_width - 1)
      @y = @generator.rand(1..@room_length - 2) # we don't want doors in corners
    else
      # north or south walls
      @x = @generator.rand(1..@room_width - 2) # we don't want doors in corners
      @y = either(0, @room_length - 1)
    end
  end

  def either(first, second)
    [first, second].sample(random: @generator)
  end

  attr_accessor :x
  attr_accessor :y
end
