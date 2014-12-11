require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    @character = '.'
    @symbol = ' '
    @seen = false
    @occupant = nil
  end

  attr_reader :occupant

  def occupy(actor)
    @occupant = actor
    if actor
      @symbol = actor.symbol
      mark_seen
    else
      seen ? @symbol = @character : @symbol = ' '
    end
  end

  def mark_seen
    @seen = true
    @symbol = @character unless occupant
  end
end
