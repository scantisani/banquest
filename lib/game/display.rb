require_relative 'info_panel'

# The display, made up of the map and the info panel to its right
class Display
  def initialize(map)
    @map = map
    @info_panel = InfoPanel.new(@map)
    redraw
  end

  def redraw
    @map.redraw
    @info_panel.redraw
  end

  def to_string
    map_strings = @map.structure.collect { |row| row.collect(&:symbol).join }
    panel_strings = @info_panel.contents
    combined_array = map_strings.zip(panel_strings)

    combined_array.map { |strings| strings.reduce(:concat) }.join("\n")
  end

  def to_html
    map_strings = @map.structure.map { |row| row.collect(&:symbol).join }
    panel_strings = @info_panel.contents
    combined_array = map_strings.zip(panel_strings)

    html = combined_array.map { |strings| strings.reduce(:concat) }.join('<br>')
    html.gsub(' ', '&nbsp;')
  end
end
