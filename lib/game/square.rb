# A single square of the dungeon
class Square
  def initialize
    @character = '`'
    @symbol = '`'
    @seen = false
  end

  attr_reader :symbol
  attr_accessor :seen

  def mark_seen
    @seen = true
    @symbol = @character
  end
end
