module RubyChessBoard
  class Bishop < Piece
    def raw_directional_moves(game)
      board    = game.board
      position = board.coordinates_of(self)
      
      [ position.relative_coordinate_set(1, 1),
        position.relative_coordinate_set(1, -1),
        position.relative_coordinate_set(-1, -1),
        position.relative_coordinate_set(-1, 1) ]
    end
  end
end
