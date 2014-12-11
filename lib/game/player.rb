require_relative 'actor'

# The player
class Player < Actor
  def initialize(x = 0, y = 0)
    super
    @symbol = '@'
    @hit_points = 20
    @damage_range = 1..6
  end
end
