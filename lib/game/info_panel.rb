# The panel containing stats and combat messages that appears next to the map
class InfoPanel
  def initialize(map)
    @map = map
    @player = map.player
    @actors = map.actors
    @contents = Array.new(40) { '|' + (' ' * 39) }
  end

  attr_reader :contents

  def redraw
    combat_messages = @actors.map(&:combat_message).compact
    @contents[10] = "| Health: #{@player.hit_points}"
    combat_messages.each_with_index do |message, i|
      @contents[11 + i] = "| #{message}"
    end
  end
end
