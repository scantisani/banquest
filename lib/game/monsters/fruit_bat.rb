require_relative '../monster'

# An irate pineapple with wings (monster)
class FruitBat < Monster
  def initialize(map, data = { x: 0, y: 0, hit_points: 5 })
    super
    @symbol = 'b'
    @damage_range = 1..3
    @sight = 4
  end
end
