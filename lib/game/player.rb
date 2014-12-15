require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, x = 0, y = 0)
    super
    @symbol = '@'
    @hit_points = 20
    @damage_range = 1..6
    map.add_actor(self)
  end
end
