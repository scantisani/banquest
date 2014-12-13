require_relative '../actor'
require_relative '../populated_map'

# Inhabitants of the dungeon that attack the player
class Monster < Actor
  def initialize(map, x = 0, y = 0)
    super
  end

  def approach(actor)
    return if next_to(actor)
    directions = [:north, :east, :south, :west,
                  :northeast, :southeast, :southwest, :northwest]

    valid_directions = directions.select do |direction|
      potential_move(direction)
    end

    best_direction = valid_directions.min_by do |direction|
      euclidean_distance(potential_move(direction), actor)
    end

    move(best_direction)
  end

  def euclidean_distance(position, actor)
    Math.sqrt((position[:x] - actor.x)**2 + (position[:y] - actor.y)**2)
  end
end
