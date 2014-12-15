require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 20 })
    super
    @symbol = '@'
    @hit_points = 20
    @damage_range = 1..6
    map.add_actor(self)
  end
end
