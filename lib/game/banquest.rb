require_relative 'map'
require_relative 'player'

# The main game loop
class Banquest
  @map = Map.new
  @player = Player.new

  @map.place_player(@player.location)

  print @map.to_string
end
