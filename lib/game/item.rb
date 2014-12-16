# An item found in the dungeon e.g. a weapon or money
class Item
  def initialize
    @name = ''
    @quantity = 1
  end

  attr_accessor :quantity

  def name
    return @name + 's' unless @quantity == 1
    @name
  end
end
