require_relative 'map'
require_relative 'player'
require_relative 'coin'

# The dungeon map occupied by the player as well as monsters.
class PopulatedMap
  MAP_SIZE = 40
  def initialize(seed, seen_squares = [])
    @rng = Random.new(seed)

    @structure = Map.new(seed).structure
    @player = nil
    @monsters = []
    load_seen(seen_squares) unless seen_squares.empty?
  end

  attr_accessor :structure
  attr_accessor :player
  attr_accessor :monsters

  def player=(new_player)
    @player = new_player
    give_starting_position(@player)
  end

  def monsters=(new_monsters)
    @monsters = new_monsters
    @monsters.each { |monster| give_starting_position(monster) }
  end

  def floor?(position)
    @structure[position[:y]][position[:x]].is_a? Floor
  end

  def save_seen
    # returns a 40 x 40 array with each element corresponding to a square
    # 1 for seen, 0 for not--by default, none are seen
    seen_squares = Array.new(MAP_SIZE) { Array.new(MAP_SIZE, 0) }

    @structure.each_with_index do |row, y|
      row.each_with_index do |square, x|
        seen_squares[y][x] = square.seen ? 1 : 0
      end
    end
    seen_squares
  end

  def load_seen(seen_squares)
    seen_squares.each_with_index do |row, y|
      row.each_with_index do |square, x|
        @structure[y][x].seen = true if square == 1
      end
    end
  end

  def redraw
    # clear occupants
    @structure.each do |row|
      row.each { |square| square.occupant = nil if square.is_a? Floor }
    end
    remove_dead

    # place occupants
    place(@player)
    @monsters.each { |monster| place(monster) }
    mark_seen if @player
  end

  def to_string
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    rows.join("\n")
  end

  def to_html
    rows = @structure.collect { |row| row.collect(&:symbol).join }
    html = rows.join('<br>')

    # we need to replace regular spaces with non-breaking ones
    # so that repeated spaces aren't condensed into one in HTML
    html.gsub(' ', '&nbsp;')
  end

  def save_items
    items = []
    @structure.each_with_index do |row, y|
      row.each_with_index do |square, x|
        next unless square.is_a? Floor
        next if square.item.nil?
        items << { x: x, y: y }.merge(square.item.save_data)
      end
    end
    items
  end

  def load_items(items)
    return if items.empty?
    items.each do |item|
      # Object.const_get converts a class name string to a plain class
      # name that we can use to make an instance of that class
      item_class = Object.const_get(item[:item_class])
      quantity = item[:item_quantity]

      @structure[item[:y]][item[:x]].item = item_class.new(quantity)
    end
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

  def remove_dead
    @monsters.reject! { |monster| !monster.alive }
  end
end
