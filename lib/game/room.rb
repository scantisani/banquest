require_relative 'door'

# A room in the dungeon.
class Room
  def initialize(generator = Random.new)
    @generator = generator

    @length = generator.rand(4..12) # y-axis
    @width = generator.rand(4..12) # x-axis
    @plan = Array.new(@length) { Array.new(@width, '.') }
  end

  def make_walls
    @plan[0].fill('#')
    @plan[1..-2].each do |row|
      row[0] = '#'
      row[-1] = '#'
    end
    @plan[-1].fill('#')
  end

  def make_doors
    number_of_doors = @generator.rand(1..4)
    number_of_doors.times do
      door = Door.new(@length, @width, @generator.rand(9999))
      @plan[door.y][door.x] = '+'
    end
  end

  def draw
    make_walls
    make_doors
    room_string = ''
    @plan.each { |x| room_string << x.join + "\n" }

    room_string
  end
end
