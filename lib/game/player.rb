require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 20 })
    super
    @symbol = '@'
    @damage_range = 1..6
    @map.add_actor(self)
  end

  def attack(actor)
    super
    messages = ["You gnaw away at the #{actor.name}!",
                "You chomp down on the #{actor.name}!",
                "You bite the #{actor.name}!",
                "You chew on the #{actor.name}.",
                "You nibble on the #{actor.name}."]
    @combat_message = messages.sample
  end

  def move(direction)
    position = potential_move(direction)
    return if position.nil?

    new_x, new_y = position[:x], position[:y]
    return (@x, @y = new_x, new_y) unless @map.structure[new_y][new_x].occupied?
    attack(@map.structure[new_y][new_x].occupant)
  end
end
