require_relative 'square'

# Doors connecting rooms in the dungeon.
class Door < Square
  def initialize
    @symbol = '+'
    @open = false
  end
  attr_reader :open

  def open
    @open = true
    @symbol = '.'
  end

  def close
    @open = false
    @symbol = '+'
  end
end
