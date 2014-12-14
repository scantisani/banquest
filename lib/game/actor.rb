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
    @sight = 4
  end

  attr_accessor :x
  attr_accessor :y
  attr_reader :symbol
  attr_reader :hit_points

  def move(direction)
    position = potential_move(direction)
    @x, @y = position[:x], position[:y] if position
  end

  def potential_move(direction)
    compass = {
      north: [0, -1], east: [1, 0], south: [0, 1], west: [-1, 0],
      northeast: [1, -1], southeast: [1, 1], southwest: [-1, 1],
      northwest: [-1, -1]
    }
    position = { x: @x + compass[direction][0], y: @y + compass[direction][1] }
    return position if @map.floor?(position)
  end

  def attack(actor)
    damage = Random.rand(@damage_range)
    actor.take_damage(damage)
  end

  def take_damage(damage)
    @hit_points -= damage
    @alive = false if @hit_points <= 0
  end

  def next_to(actor)
    column = (actor.x - 1..actor.x + 1).include? @x
    row    = (actor.y - 1..actor.y + 1).include? @y
    row && column
  end

  def sees(place)
    return false unless euclidean_distance(@x, @y, place[:x], place[:y]) <= @sight

    line_of_sight = get_line(@x, @y, place[:x], place[:y])
    line_of_sight.each do |point|
      square = @map.structure[point[:y]][point[:x]]
      return false if square.is_a? Wall
    end
    true
  end

  private

  def get_line(x0, y0, x1, y1)
    # (slightly modified) Bresenham algorithm taken from RogueBasin
    points = []

    steep = ((y1 - y0).abs) > ((x1 - x0).abs)
    if steep
      # use y as the variable to increment instead
      x0, y0 = y0, x0
      x1, y1 = y1, x1
    end

    if x0 > x1
      # switch starting point (we want leftmost)
      x0, x1 = x1, x0
      y0, y1 = y1, y0
    end

    # we use these to approximate the y/x ratio of the gradient
    delta_x = x1 - x0
    delta_y = (y1 - y0).abs
    error = (delta_x / 2).to_i

    y = y0
    y0 < y1 ? step = 1 : step = -1

    (x0..x1).each do |x|
      steep ? points << { x: y, y: x } : points << { x: x, y: y }

      error -= delta_y
      next if error >= 0
      # e.g. if the gradient is 1/2; we've done our 2 x steps right,
      # now time for the 1 y step up
      y += step
      error += delta_x
    end
    points
  end

  def euclidean_distance(x0, y0, x1, y1)
    Math.sqrt((x1 - x0)**2 + (y1 - y0)**2)
  end
end
