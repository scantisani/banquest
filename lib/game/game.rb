require_relative 'map'

# The main game loop
class Game
  map = Map.new
  print map.to_string
end
