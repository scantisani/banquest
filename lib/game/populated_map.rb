require_relative 'map'
require_relative 'player'

# The dungeon map occupied by the player as well as monsters.
class PopulatedMap
  MAP_SIZE = 40
  def initialize(player, seed)
    @rng = Random.new(seed)

    @map = Map.new(seed).structure
    @player = player
    @actors = [@player]

    populate
  end

  def valid_movement(direction, actor)
    clone = actor.clone
    clone.move(direction)
    @map[clone.y][clone.x].is_a? Floor
  end

  def redraw
    # clear occupants
    @map.each do |row|
      row.each { |square| square.occupy(nil) if square.is_a? Floor }
    end
    # place occupants
    @actors.each { |actor| place(actor) }
    mark_seen
  end

  def to_string
    rows = @map.collect { |row| row.collect(&:symbol).join }
    rows.join("\n")
  end

  def to_html
    rows = @map.collect { |row| row.collect(&:symbol).join }
    rows.join('<br>')
  end

  private

  def populate
    @actors.each do |actor|
      x, y = actor.x, actor.y
      until @map[y][x].is_a? Floor
        x, y = @rng.rand(1..MAP_SIZE - 1), @rng.rand(1..MAP_SIZE - 1)
      end
      actor.x, actor.y = x, y
      place(actor)
    end
  end

  def place(actor)
    @map[actor.y][actor.x].occupy(actor)
  end

  def mark_seen
    @map[@player.y - 3..@player.y + 3].each do |row|
      row[@player.x - 3..@player.x + 3].each do |square|
        square.mark_seen
      end
    end
  end
end
