require_relative '../monster'

# An irate pineapple with wings (monster)
class FruitBat < Monster
  def initialize(map, data = { x: 0, y: 0, hit_points: 5 })
    super
    @symbol = 'b'
    @damage_range = 1..3
    @sight = 4
    @name = 'fruit bat'
  end

  def attack(actor)
    super
    messages = ['The fruit bat squirts juice in your eyes!',
                'The fruit bat drops an apple on your head!',
                'The fruit bat pokes at you with its stem!']
    @combat_message = messages.sample
  end
end
