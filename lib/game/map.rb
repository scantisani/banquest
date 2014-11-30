# Generates the map for each game.
class Map
  def initialize(player)
    # the dungeon
    @structure = Array.new(10) { Array.new(10, '.') }

    # things in the dungeon
    @occupying_dungeon = Array.new(10) { Array.new(10, '') }
    @player = player
  end

  def draw
    place_occupants

    map_string = ''
    @structure.each_index do |i|
      @structure[i].each_index do |j|
        if @occupying_dungeon[i][j] != ''
          map_string += @occupying_dungeon[i][j]
        else
          map_string += @structure[i][j]
        end
      end
      map_string += "\n"
    end
    map_string
  end

  def place_occupants
    clear_occupants
    @occupying_dungeon[@player.y][@player.x] = '@'
  end

  def clear_occupants
    @occupying_dungeon = Array.new(10) { Array.new(10, '') }
  end
end
