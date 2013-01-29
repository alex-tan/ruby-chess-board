module RubyChessBoard
  class Rook < Piece
    def raw_directional_moves(game)
      board    = game.board
      position = board.coordinates_of(self)

      [
        position.relative_coordinate_set(0, 1),
        position.relative_coordinate_set(1, 0),
        position.relative_coordinate_set(0, -1),
        position.relative_coordinate_set(-1, 0)
      ]
    end
  end
end
