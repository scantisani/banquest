require_relative '../actor'

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
      position = potential_move(direction)
      euclidean_distance(position[:x], position[:y], actor.x, actor.y)
    end

    move(best_direction)
  end
end
