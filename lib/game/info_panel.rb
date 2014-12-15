# The panel containing stats and combat messages that appears next to the map
class InfoPanel
  def initialize(map)
    @map = map
    @player = map.player
    @contents = Array.new(40) { '|' + (' ' * 39) }
  end

  attr_reader :contents

  def redraw
    @contents[10] = "| Health: #{@player.hit_points}"
  end
end
