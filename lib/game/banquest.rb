require_relative 'map'
require_relative 'player'
# require 'io/console'

# The main game loop
class Banquest
  def initialize
    @player = Player.new
    @map = Map.new(@player)
  end

  def keypress(key)
    case key
    when 'h'
      @player.move('west')
    when 'j'
      @player.move('south')
    when 'k'
      @player.move('north')
    when 'l'
      @player.move('east')
    end
    print @map.draw + "\n"
  end
end

# b = Banquest.new

# key = 'a'
# until key == 'q'
#   key = STDIN.getch
#   b.keypress(key)
# end
