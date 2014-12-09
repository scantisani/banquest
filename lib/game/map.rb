require_relative 'player'
require_relative 'room'
require_relative 'wall'

# Generates the map for each game.
class Map
  MAP_SIZE = 50

  def initialize(
    # player = Player.new,
    seed)
    @rng = Random.new(seed)
    # the dungeon
    @structure = Array.new(MAP_SIZE) { Array.new(MAP_SIZE, Wall.new) }
    @rooms = []

    generate

    # things in the dungeon
    # @occupying_dungeon = Array.new(10) { Array.new(10, '') }
    # @player = player
  end

  def to_string
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    rows.join("\n")
  end

  private

  def generate
    make_rooms
    place_rooms
    connect_rooms
  end

  def make_rooms
    @rng.rand(8..10).times { @rooms << Room.new(@rng.rand(9999)) }
  end

  def place_rooms
    @rooms.each do |room|
      room.origin = new_origin(room.length, room.width)
      x, y = room.origin[:x], room.origin[:y]

      room.plan.each_index do |i|
        room.plan[i].each_with_index do |square, j|
          @structure[y + i][x + j] = square
        end
      end
    end
  end

  def new_origin(length, width)
    # TODO: add detection for collisions?
    x = y = 1
    until @structure[y][x].is_a? Wall
      x = @rng.rand(1..MAP_SIZE - 1 - width)
      y = @rng.rand(1..MAP_SIZE - 1 - length)
    end
    { x: x, y: y }
  end

  def connect_rooms
    unconnected_rooms = @rooms.clone
    connected_rooms = [@rooms[1..-1].sample(random: @rng)]

    until unconnected_rooms.empty?
      unconnected_rooms.each do |room|
        other_rooms = connected_rooms.reject { |x| x == room }
        close_room = closest_room(room, other_rooms)

        make_corridor(room, close_room)
        unconnected_rooms.reject! { |x| x == room || x == close_room }
      end
    end
  end

  def closest_room(room, compared_rooms)
    compared_rooms.min_by { |x| euclidean_distance(room.origin, x.origin) }
  end

  def euclidean_distance(p, q)
    Math.sqrt((p[:x] - q[:x])**2 + (p[:y] - q[:y])**2)
  end

  def make_corridor(room_1, room_2)
    start = random_room_square(room_1)
    finish = random_room_square(room_2)

    x_range = [start[:x], finish[:x]].min..[start[:x], finish[:x]].max
    y_range = [start[:y], finish[:y]].min..[start[:y], finish[:y]].max

    x_range.each { |x| @structure[start[:y]][x] = Floor.new }
    y_range.each { |y| @structure[y][finish[:x]] = Floor.new }
  end

  def random_room_square(room)
    x = room.origin[:x] + @rng.rand(0..room.width - 1)
    y = room.origin[:y] + @rng.rand(0..room.length - 1)
    { x: x, y: y }
  end

  def place_occupants
    clear_occupants
    @occupying_dungeon[@player.y][@player.x] = '@'
  end

  def clear_occupants
    @occupying_dungeon = Array.new(10) { Array.new(10, '') }
  end
end
