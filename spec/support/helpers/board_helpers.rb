module BoardHelpers
  def coordinates(*coordinates)
    coordinates.map { |c| RubyChessBoard::BoardCoordinate.new(c) }
  end

  def coordinate(coordinate)
    RubyChessBoard::BoardCoordinate.new(coordinate)
  end
end
