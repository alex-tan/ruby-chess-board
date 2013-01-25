module RubyChessBoard
  class Pawn < Piece
    # @private
    def raw_directional_moves(board)
      position = board.coordinates_of(self)
      
      if position.rank == starting_rank 
        moves = [ position.relative_coordinate_set(0, rank_direction, limit: 2) ]
      else
        moves = [ position.relative_coordinate(0, rank_direction) ]
      end

      takeable_coordinates(position).each do |coordinate|
        at_square = board.at_square(coordinate.square)
        moves << coordinate if takeable?(at_square)
      end

      moves
    end
    
    # The rank that the pawn starts in in a traditional board setup.
    def starting_rank
      if white?     then 2
      elsif black?  then 7
      end
    end

    # The y direction that the pawn moves in.
    def rank_direction
      if white?     then 1
      elsif black?  then -1
      end
    end

    private

    def takeable?(variable)
      variable.kind_of?(Piece) && variable.color == opposite_color 
    end

    def takeable_coordinates(position)
      [
        position.relative_coordinate(1, rank_direction),
        position.relative_coordinate(-1, rank_direction)
      ].reject { |m| m.kind_of?(BoardCoordinate::ImpossibleCoordinate) }
    end
  end
end
