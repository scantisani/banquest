require_relative 'actor'

# Inhabitants of the dungeon that attack the player
class Monster < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 1 })
    super
    @player = map.player
  end

  def take_turn
    return @alive = false if @hit_points <= 0
    if next_to(@player)
      attack(@player)
    else
      sees({ x: @player.x, y: @player.y }) ? approach(@player) : wander
    end
  end

  private

  def approach(actor)
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

  def wander
    directions = [:north, :east, :south, :west,
                  :northeast, :southeast, :southwest, :northwest]
    move(directions.sample)
  end
end
