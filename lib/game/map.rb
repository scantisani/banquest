# Generates the map for each game.
class Map
  def initialize
    @squares = Array.new(10) { Array.new(10, '.') }
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
