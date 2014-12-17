require_relative 'actor'

# The player
class Player < Actor
  def initialize(map, data = { x: 0, y: 0, hit_points: 20,
                               hunger: 100, inventory: [] })
    super
    @symbol = '@'
    @damage_range = 1..6
    @map.player = self
    @hunger = data[:hunger]
    @inventory = load_items(data[:inventory])
  end

  attr_reader :inventory

  ATTACK_MESSAGES = ['You gnaw away at the NAME!',
                     'You chomp down on the NAME!',
                     'You bite the NAME!',
                     'You chew on the NAME.',
                     'You nibble on the NAME.',
                     'You stuff a hunk of the NAME into your mouth.',
                     'You sink your teeth into the NAME!']

  KILL_MESSAGES = ['You devour the NAME whole!',
                   'You tear the NAME to shreds with your teeth!',
                   'You eat the last morsel of the NAME.',
                   'You reduce the NAME to bones and gristle.',
                   'You slurp up the last of the NAME.']

  HUNGER_MESSAGES = ['You are wasting away from lack of food!',
                     'You are starving!',
                     'You are ravenous!',
                     'You are positively famished.',
                     'You could eat a whole horse.',
                     'Your belly rumbles.',
                     'You are definitely getting hungry.',
                     'You feel a little peckish.',
                     'You are full.',
                     'You are absolutely stuffed.']

  def attack(actor)
    super
    if actor.hit_points > 0
      @combat_message = ATTACK_MESSAGES.sample
    else
      @combat_message = KILL_MESSAGES.sample
    end
    @combat_message.sub!(/NAME/, actor.name)
  end

  def move(direction)
    snack

    position = potential_move(direction)
    return if position.nil?

    new_x, new_y = position[:x], position[:y]

    if @map.structure[new_y][new_x].occupied?
      attack(@map.structure[new_y][new_x].occupant)
    else
      @x, @y = new_x, new_y
    end

    search_floor
  end

  def hunger_message
    HUNGER_MESSAGES[@hunger / 20]
  end

  def save_data
    { x: @x, y: @y, hit_points: @hit_points, hunger: @hunger,
      inventory: @inventory.map(&:save_data) }
  end

  def snack
    @hunger -= 1 if @hunger > 0
    @hit_points -= 1 if @hunger < 20
  end

  def search_floor
    item = @map.structure[@y][@x].item
    return if item.nil?
    @inventory << item

    @map.structure[@y][@x].item = nil
  end

  def load_items(items)
    inventory = []
    items.each do |item|
      item_class = Object.const_get(item[:item_class])
      quantity = item[:item_quantity]
      inventory << item_class.new(quantity)
    end
    inventory
  end
end
