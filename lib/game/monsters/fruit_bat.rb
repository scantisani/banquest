require_relative '../monster'

# An irate pineapple with wings (monster)
class FruitBat < Monster
  def initialize(map, x = 0, y = 0)
    super
    @symbol = 'b'
    @hit_points = 5
    @damage_range = 1..3
    @sight = 4
  end
end
