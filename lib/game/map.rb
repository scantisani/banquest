# Generates the map for each game.
class Map
  def initialize
    @map_array = Array.new(10) { Array.new(10, '.') }
  end

  def to_string
    @map_string = ''
    @map_array.each do |row|
      @map_string += row.join + "\n"
    end
    @map_string
  end
end
