# typed: true
module RubyChessBoard
  # A knight chess piece.
  class Knight < Piece
    # @private
    def raw_directional_moves(game)
      position = coordinates_in_game(game)

      CoordinateCollection.new coordinates: [
        position.relative_coordinate(1, 2),
        position.relative_coordinate(2, 1),
        position.relative_coordinate(2, -1),
        position.relative_coordinate(1, -2),
        position.relative_coordinate(-1, -2),
        position.relative_coordinate(-2, -1),
        position.relative_coordinate(-2, 1),
        position.relative_coordinate(-1, 2)
      ]
    end
  end
end
