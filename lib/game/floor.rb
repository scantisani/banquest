require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    super
    @character = '.'
    @occupant = nil
  end

  attr_reader :occupant

  def occupy(actor)
    @occupant = actor
    if actor
      mark_seen if actor.is_a? Player
    else
      seen ? @symbol = @character : @symbol = ' '
    end
  end

  def mark_seen
    @seen = true
    return @symbol = @character unless occupant
    @symbol = @occupant.symbol
  end
end
