require 'test/unit'
require_relative '../lib/game/populated_map.rb'
require_relative '../lib/game/map.rb'
require_relative '../lib/game/player.rb'
require_relative '../lib/game/coin.rb'

# Unit tests for populated_map.rb
class TestPopulatedMap < Test::Unit::TestCase
  def setup
    @seed = Random.rand(9999)
    @control_map = Map.new(@seed)
    @control_pop_map = PopulatedMap.new(@seed)
    @control_player = Player.new(@control_pop_map)
  end

  def test_valid_player_placement
    assert_same(@control_pop_map.player, @control_player)
    @control_pop_map.structure[@control_player.y][@control_player.x].is_a? Floor
  end

  def test_load_and_save_seen
    seen = @control_pop_map.save_seen
    reloaded_map = @control_pop_map.clone
    reloaded_map.load_seen(seen)
    assert_equal(seen, reloaded_map.save_seen)
  end

  def test_redraw_side_effects
    @control_pop_map.redraw
    redrawn = @control_pop_map
    redrawn.redraw
    assert_equal(redrawn.to_html, @control_pop_map.to_html)
  end

  def test_load_and_save_items
    map_with_items = PopulatedMap.new(1234) # [7][7] is a Floor on this map
    map_with_items.structure[7][7].item = Coin.new(42)

    saved_items = map_with_items.save_items
    reloaded_map = PopulatedMap.new(1234)
    reloaded_map.load_items(saved_items)

    assert_equal(Coin, reloaded_map.structure[7][7].item.class)
    assert_equal(42, reloaded_map.structure[7][7].item.quantity)
  end
end
