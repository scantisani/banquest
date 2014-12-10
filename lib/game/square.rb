# A single square of the dungeon
class Square
  def initialize
    @core_symbol = ' '
    @symbol = @core_symbol
    @occupant = nil
  end

  attr_reader :symbol
  attr_reader :occupant

  def occupy(actor)
    @occupant = actor
    actor ? @symbol = actor.symbol : @symbol = @core_symbol
  end
end
