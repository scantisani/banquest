require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 20 })
    super
    @symbol = '@'
    @damage_range = 1..6
    @map.player = self
  end

  def attack(actor)
    super
    messages = ["You gnaw away at the #{actor.name}!",
                "You chomp down on the #{actor.name}!",
                "You bite the #{actor.name}!",
                "You chew on the #{actor.name}.",
                "You nibble on the #{actor.name}.",
                "You stuff a hunk of the #{actor.name} into your mouth.",
                "You sink your teeth into the #{actor.name}!"]
    return @combat_message = messages.sample if actor.hit_points > 0
    kill_messages = ["You devour the #{actor.name} whole!",
                     "You tear the #{actor.name} to shreds with your teeth!",
                     "You eat the last morsel of the #{actor.name}.",
                     "You reduce the #{actor.name} to bones and gristle.",
                     "You slurp up the last of the #{actor.name}."]
    @combat_message = kill_messages.sample
  end

  def move(direction)
    position = potential_move(direction)
    return if position.nil?

    new_x, new_y = position[:x], position[:y]
    return (@x, @y = new_x, new_y) unless @map.structure[new_y][new_x].occupied?
    attack(@map.structure[new_y][new_x].occupant)
  end
end
