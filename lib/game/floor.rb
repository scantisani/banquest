require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    @character = '.'
    @symbol = '`'
    @seen = false
    @occupant = nil
  end

  attr_reader :occupant

  def occupy(actor)
    @occupant = actor
    @symbol = actor.symbol if actor
  end

  def mark_seen
    @seen = true
    @symbol = @character unless occupant
  end
end
