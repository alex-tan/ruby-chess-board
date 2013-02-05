module RubyChessBoard
  class Bishop < Piece
    # @private
    def raw_directional_moves(game)
      position = coordinates_in_game(game)
      
      CoordinateCollection.new sets: [
        position.relative_coordinate_set(1, 1),
        position.relative_coordinate_set(1, -1),
        position.relative_coordinate_set(-1, -1),
        position.relative_coordinate_set(-1, 1) ]
    end
  end
end
