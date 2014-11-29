require_relative 'map'

# The main game loop
class Banquest
  map = Map.new
  print map.to_string
end
