module RubyChessBoard
  class Bishop < Piece
    # @private
    def raw_directional_moves(game)
      board    = game.board
      position = board.coordinates_of(self)
      
      CoordinateCollection.new sets: [
        position.relative_coordinate_set(1, 1),
        position.relative_coordinate_set(1, -1),
        position.relative_coordinate_set(-1, -1),
        position.relative_coordinate_set(-1, 1) ]
    end
  end
end
