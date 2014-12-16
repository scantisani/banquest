# The panel containing stats and combat messages that appears next to the map
class InfoPanel
  def initialize(map)
    @map = map
    @player = map.player
    @monsters = map.monsters
    @contents = Array.new(40) { '|' + (' ' * 39) }
  end

  attr_reader :contents

  def redraw
    @contents = Array.new(40) { '|' + (' ' * 39) }

    combat_messages = @monsters.map(&:combat_message) + [@player.combat_message]
    combat_messages.compact!
    @contents[10] = "| Health: #{@player.hit_points}"
    combat_messages.each_with_index do |message, i|
      @contents[11 + i] = "| #{message}"
    end
  end
end
