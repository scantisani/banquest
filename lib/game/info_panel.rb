# The panel containing stats and combat messages that appears next to the map
class InfoPanel
  def initialize(map)
    @map = map
    @player = map.player
    @monsters = map.monsters
    @contents = DEFAULT_CONTENTS.clone
  end

  DEFAULT_CONTENTS = ['|' + '-' * 39] +
                     ['| INVENTORY'] +
                     ['|' + '-' * 39] +
                     Array.new(7) { '|' + (' ' * 39) } +
                     ['|' + '-' * 39] +
                     ['| COMBAT'] +
                     ['|' + '-' * 39] +
                     Array.new(5) { '|' + (' ' * 39) } +
                     ['|' + '-' * 39] +
                     ['| STATUS'] +
                     ['|' + '-' * 39] +
                     Array.new(5) { '|' + (' ' * 39) } +
                     ['| h, j, k and l to move left, down, up and right.'] +
                     ['| y, u, b, and n move diagonally.'] +
                     ['| Moving will automatically attack and pick up items.'] +
                     ['| Your progress is saved automatically.'] +
                     Array.new(10) { '|' + (' ' * 39) }

  attr_reader :contents

  def redraw
    @contents = DEFAULT_CONTENTS.dup

    return unless @player
    draw_inventory
    draw_status_messages
    draw_combat_messages
  end

  def draw_inventory
    @player.inventory.each_with_index do |item, i|
      @contents[3 + i] = "| #{item.quantity} #{item.name}"
    end
  end

  def draw_combat_messages
    combat_messages = @monsters.map(&:combat_message) + [@player.combat_message]
    combat_messages.compact!
    combat_messages.each_with_index do |message, i|
      @contents[13 + i] = "| #{message}"
    end
  end

  def draw_status_messages
    @contents[21] = "| Health: #{@player.hit_points}"
    @contents[22] = "| #{@player.hunger_message}"
  end
end
