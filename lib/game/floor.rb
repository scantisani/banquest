require_relative 'square'

# A floor square in the dungeon.
class Floor < Square
  def initialize
    super
    @character = '.'
    @occupant = nil
    @item = nil
  end

  attr_accessor :occupant
  attr_accessor :item

  def occupy(actor)
    @occupant = actor
    @seen = true if actor.is_a? Player
  end

  def occupied?
    !occupant.nil?
  end

  def symbol
    return ' ' unless @seen
    return @character unless @item || @occupant
    return @item.symbol unless @occupant
    @occupant.symbol
  end
end
