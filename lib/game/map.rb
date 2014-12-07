require_relative 'player'
require_relative 'room'

# Generates the map for each game.
class Map
  MAP_SIZE = 50

  def initialize(
    # player = Player.new,
    seed)
    @rng = Random.new(seed)
    # the dungeon
    @structure = Array.new(MAP_SIZE) { Array.new(MAP_SIZE, Square.new) }
    @rooms = make_rooms

    # things in the dungeon
    # @occupying_dungeon = Array.new(10) { Array.new(10, '') }
    # @player = player
  end

  def make_rooms
    rooms = []
    @rng.rand(3..6).times { rooms << Room.new(@rng.rand(9999)) }
    rooms
  end

  def place_rooms
    @rooms.each do |room|
      origin = new_origin(room.length, room.width)
      x, y = origin[0], origin[1]

      room.plan.each_index do |i|
        room.plan[i].each_with_index do |square, j|
          @structure[y + i][x + j] = square
        end
      end
    end
  end

  def new_origin(length, width)
    # TODO: add detection for collisions
    x = y = 3
    until @structure[y][x].symbol == ' '
      x = @rng.rand(0..MAP_SIZE - 1 - width)
      y = @rng.rand(0..MAP_SIZE - 1 - length)
    end
    [x, y]
  end

  def to_string
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    rows.join("\n")
  end

  private

  def place_occupants
    clear_occupants
    @occupying_dungeon[@player.y][@player.x] = '@'
  end

  def clear_occupants
    @occupying_dungeon = Array.new(10) { Array.new(10, '') }
  end
end
