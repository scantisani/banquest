# A single square of the dungeon
class Square
  def initialize
    @character = ' '
    @seen = false
  end

  attr_accessor :seen

  def symbol
    return ' ' unless @seen
    @character
  end
end
