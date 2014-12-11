require_relative 'square'

# A wall square in the dungeon.
class Wall < Square
  def initialize
    super
    @character = '#'
  end
end
