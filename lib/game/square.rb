# A single square of the dungeon
class Square
  def initialize
    @symbol = ' '
    @occupied = false
  end
  attr_reader :symbol
  attr_reader :occupied
end
