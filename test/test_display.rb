require 'test/unit'
require_relative '../lib/game/display.rb'
require_relative '../lib/game/info_panel.rb'
require_relative '../lib/game/populated_map.rb'

# Unit tests for display.rb
class TestDisplay < Test::Unit::TestCase
  def setup
    @map = PopulatedMap.new(Random.rand(9999))
    @control = Display.new(@map)
  end

  def test_no_breaking_spaces_in_html
    assert(@control.to_html.index(' ').nil?)
  end

  def test_map_zipped_to_info_panel
    info = InfoPanel.new(@map)
    map_strings = @map.structure.collect { |row| row.collect(&:symbol).join }
    panel_strings = info.contents
    zipped = map_strings.zip(panel_strings)

    zipped = zipped.map { |strings| strings.reduce(:concat) }.join("\n")
    assert_equal(zipped, @control.to_string)
  end
end
