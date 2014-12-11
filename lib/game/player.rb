require_relative 'actor'

# The player
class Player < Actor
  def initialize(x = 0, y = 0)
    super
    @symbol = '@'
  end
end
