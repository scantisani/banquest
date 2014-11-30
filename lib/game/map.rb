# Generates the map for each game.
class Map
  def initialize
    @dungeon_squares = Array.new(10) { Array.new(10, '.') }
    @squares = @dungeon_squares.dup
  end

  def place_player(loc)
    i = loc[0]
    j = loc[1]
    squares[j][i] = '@'
  end

  def to_string
    @map_string = ''
    @squares.each do |row|
      @map_string += row.join + "\n"
    end
    @map_string
  end

  attr_accessor :squares
end
