# The panel containing stats and combat messages that appears next to the map
class InfoPanel
  def initialize(map)
    @map = map
    @player = map.player
    @monsters = map.monsters
    @contents = DEFAULT_CONTENTS.clone
  end

  DEFAULT_CONTENTS = Array.new(10) { '|' + (' ' * 39) } +
                     ['|' + '-' * 39] +
                     ['| COMBAT'] +
                     ['|' + '-' * 39] +
                     Array.new(5) { '|' + (' ' * 39) } +
                     ['|' + '-' * 39] +
                     ['| STATUS'] +
                     ['|' + '-' * 39] +
                     Array.new(19) { '|' + (' ' * 39) }

  attr_reader :contents

  def redraw
    @contents = DEFAULT_CONTENTS.dup

    combat_messages = @monsters.map(&:combat_message) + [@player.combat_message]
    combat_messages.compact!
    combat_messages.each_with_index do |message, i|
      @contents[13 + i] = "| #{message}"
    end

    @contents[21] = "| Health: #{@player.hit_points}"
    @contents[22] = "| #{@player.hunger_message}"
  end
end
