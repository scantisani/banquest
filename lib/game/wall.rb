require_relative 'square'

# A wall square in the dungeon.
class Wall < Square
  def initialize
    @character = '#'
    @symbol = '`'
    @seen = false
  end
end
