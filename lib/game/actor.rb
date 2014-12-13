# The player or a monster
class Actor
  def initialize(map, x = 0, y = 0)
    @x = x
    @y = y
    @symbol = ''
    @map = map
    @map.add_actor(self)

    @alive = true
    @hit_points = 1
    @damage_range = 0..0
  end

  attr_accessor :x
  attr_accessor :y
  attr_reader :symbol

  def move(direction)
    position = potential_move(direction)
    @x, @y = position[:x], position[:y] if @map.floor?(position)
  end

  def potential_move(direction)
    compass = {
      north: [0, -1], east: [1, 0], south: [0, 1], west: [-1, 0],
      northeast: [1, -1], southeast: [1, 1], southwest: [-1, 1],
      northwest: [-1, -1]
    }
    { x: @x + compass[direction][0], y: @y + compass[direction][1] }
  end

  def attack(actor)
    damage = Random.rand(@damage_range)
    actor.take_damage(damage)
  end

  def take_damage(damage)
    @hit_points -= damage
    @alive = false if @hit_points <= 0
  end
end
