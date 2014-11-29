require_relative 'map'
require_relative 'player'

# The main game loop
class Banquest
  @map = Map.new
  @player = Player.new

  i = @player.location[0]
  j = @player.location[1]

  @map.squares[j][i] = '@'

  print map.to_string
end
