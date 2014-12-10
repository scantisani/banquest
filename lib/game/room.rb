require_relative 'floor'

# A room in the dungeon.
class Room
  def initialize(seed)
    @rng = Random.new(seed)

    @length = @rng.rand(4..12) # y-axis
    @width = @rng.rand(4..12) # x-axis
    @origin = { x: 0, y: 0 }

    @plan = Array.new(@length) { Array.new(@width) { Floor.new } }
  end

  attr_reader :plan
  attr_reader :length
  attr_reader :width

  attr_accessor :origin
end
