module BoardHelpers
  # Return an array of coordinates.
  def coordinate_array(*coordinates)
    coordinates.map { |c| coordinate(c) }
  end

  # Return a CoordinateSet
  def coordinate_set(*coordinates)
    coords = coordinate_array(*coordinates)
    build(:coordinate_set, coordinates: coords)
  end
  
  # Return a single coordinate.
  def coordinate(coordinate)
    RubyChessBoard::BoardCoordinate.new(coordinate)
  end
end
