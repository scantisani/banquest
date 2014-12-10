require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    @character = '.'
    @symbol = @character
    @occupant = nil
  end

  attr_reader :occupant

  def occupy(actor)
    @occupant = actor
    actor ? @symbol = actor.symbol : @symbol = @character
  end
end
