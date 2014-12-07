require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    @symbol = '.'
  end
end
