require_relative 'map'
require_relative 'player'

# The dungeon map occupied by the player as well as monsters.
class PopulatedMap
  MAP_SIZE = 40
  def initialize(seed, seen_squares = [])
    @rng = Random.new(seed)

    @structure = Map.new(seed).structure
    @player = nil
    @actors = []
    load_seen(seen_squares) unless seen_squares.empty?
  end

  attr_accessor :structure
  attr_reader :player
  attr_reader :actors

  def add_actor(actor)
    @actors << actor
    @player = actor if actor.is_a? Player
    give_starting_position(actor)
  end

  def floor?(position)
    @structure[position[:y]][position[:x]].is_a? Floor
  end

  def save_seen
    seen_squares = []
    @structure.each_with_index do |row, y|
      row.each_with_index do |square, x|
        seen_squares << [x, y] if square.seen
      end
    end
    seen_squares
  end

  def load_seen(seen_squares)
    seen_squares.each do |coordinates|
      @structure[coordinates[1]][coordinates[0]].seen = true
    end
  end

  def redraw
    # clear occupants
    @structure.each do |row|
      row.each { |square| square.occupant = nil if square.is_a? Floor }
    end
    remove_dead
    # place occupants
    @actors.each { |actor| place(actor) }
    mark_seen if @player
  end

  def to_string
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    rows.join("\n")
  end

  def to_html
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    html = rows.join('<br>')
    html.gsub(' ', '&nbsp;')
  end

  private

  def give_starting_position(actor)
    x, y = actor.x, actor.y
    until @structure[y][x].is_a? Floor
      x, y = @rng.rand(1..MAP_SIZE - 1), @rng.rand(1..MAP_SIZE - 1)
    end
    actor.x, actor.y = x, y
    place(actor)
  end

  def place(actor)
    @structure[actor.y][actor.x].occupy(actor)
  end

  def mark_seen
    @structure[@player.y - 3..@player.y + 3].each do |row|
      row[@player.x - 3..@player.x + 3].each { |square| square.seen = true }
    end
  end
end
