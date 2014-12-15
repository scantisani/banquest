require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 20 })
    super
    @symbol = '@'
    @damage_range = 1..6
    map.add_actor(self)
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
end
