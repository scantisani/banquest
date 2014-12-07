require_relative 'door'
require_relative 'floor'
require_relative 'wall'

# A room in the dungeon.
class Room
  def initialize(generator = Random.new)
    @generator = generator

    @length = generator.rand(4..12) # y-axis
    @width = generator.rand(4..12) # x-axis

    @plan = Array.new(@length) { Array.new(@width, Floor.new) }
    @doors = []
    make_structure
  end

  attr_reader :doors

  private

  def make_structure
    make_walls
    make_doors
  end

  def make_walls
    @plan[0].fill(Wall.new)
    @plan[1..-2].each do |row|
      row[0] = Wall.new
      row[-1] = Wall.new
    end
    @plan[-1].fill(Wall.new)
  end

  def make_doors
    # array starts at 0, so we need -1 for last value, -2 for 2nd-last value
    @generator.rand(1..4).times do
      if either(true, false)
        # east or west walls
        x = either(0, @width - 1)
        y = @generator.rand(1..@length - 2) # we don't want doors in corners
      else
        # north or south walls
        x = @generator.rand(1..@width - 2) # we don't want doors in corners
        y = either(0, @length - 1)
      end
      @plan[y][x] = Door.new
      @doors << [x, y]
    end
  end

  def either(first, second)
    [first, second].sample(random: @generator)
  end
  #
  # def draw
  #   room_string = ''
  #   @plan.each do |row|
  #     row.each { |square| room_string << square.symbol }
  #     room_string << "\n"
  #   end
  #   room_string
  # end
end
