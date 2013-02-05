module RubyChessBoard
  # A rook chess piece.
  class Rook < Piece
    # @private
    def raw_directional_moves(game)
      position = coordinates_in_game(game)

      CoordinateCollection.new sets: [
        position.relative_coordinate_set(0, 1),
        position.relative_coordinate_set(1, 0),
        position.relative_coordinate_set(0, -1),
        position.relative_coordinate_set(-1, 0)
      ]
    end
  end
end
