module RubyChessBoard
  class Knight < Piece
    # @private
    def raw_directional_moves(game)
      board    = game.board
      position = board.coordinates_of(self)

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
