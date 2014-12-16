# An item found in the dungeon e.g. a weapon or money
class Item
  def initialize
    @name = ''
    @quantity = 1
    @symbol = ''
  end

  attr_accessor :quantity
  attr_reader :symbol

  def name
    return @name + 's' unless @quantity == 1
    @name
  end
end
