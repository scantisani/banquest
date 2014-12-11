require 'test/unit'
require_relative '../lib/game/map.rb'

# Unit tests for map.rb
class MapTest < Test::Unit::TestCase
  def test_outer_walls
    map = Map.new(Random.rand(9999))

    map.structure[0..2].each { |row| row.each { |square| assert(square.is_a? Wall) } }
    map.structure.each { |row| row[0..2].each { |square| assert(square.is_a? Wall) } }

    map.structure[-3..-1].each { |row| row.each { |square| assert(square.is_a? Wall) } }
    map.structure.each { |row| row[-3..-1].each { |square| assert(square.is_a? Wall) } }
  end

  def test_seeded_generation
    # is there a better way to do this?
    seed = Random.rand(9999)
    map_1 = Map.new(seed)
    map_2 = Map.new(seed)
    map_1.structure.each_with_index do |row, y|
      row.each_with_index do |square, x|
        assert(map_2.structure[y][x].is_a? square.class)
      end
    end
  end
end
