require_relative 'item'

# The currency of the game
class Coin < Item
  def initialize(quantity = 1)
    @name = 'chocolate coin'
    @quantity = quantity
    @symbol = '*'
  end
end
