module RubyChessBoard
  class King < Piece
    # @private
    def raw_directional_moves(game)
      position = coordinates_in_game(game)

      CoordinateCollection.new coordinates: [
        position.relative_coordinate(0, 1),
        position.relative_coordinate(1, 1),
        position.relative_coordinate(1, 0),
        position.relative_coordinate(1, -1),
        position.relative_coordinate(0, -1),
        position.relative_coordinate(-1, -1),
        position.relative_coordinate(-1, 0),
        position.relative_coordinate(-1, 1)
      ]
    end 
  end
end
