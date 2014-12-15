current_dir = File.expand_path(File.dirname(__FILE__))
Dir.glob(current_dir + '/monsters/*.rb').each { |file| require file }

# Generates a set of monsters of random types
class MonsterGenerator
  def initialize(map, number_of_monsters)
    @map = map
    @monsters = Array.new(number_of_monsters) { generate_monster }
    @monsters.each { |monster| @map.add_actor(monster) }
  end

  attr_reader :monsters

  def generate_monster
    monster_types = [FruitBat.new(@map)]
    monster_types.sample
  end
end
