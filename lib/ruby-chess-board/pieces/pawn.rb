module RubyChessBoard
  class Pawn < Piece
    include CoordinateHelpers

    class <<self
      def starting_ranks
        { white: 2, black: 7 }
      end

      def rank_directions
        { white: 1, black: -1 }
      end
    end

    # @private
    def raw_directional_moves(board)
      position = board.coordinates_of(self)
      
      if position.rank == starting_rank 
        moves = [ position.relative_coordinate_set(0, rank_direction, limit: 2) ]
      else
        moves = [ position.relative_coordinate(0, rank_direction) ]
      end

      takeable_coordinates(position).each do |coordinate|
        at_square = board.at_square(coordinate.square_name)
        moves << coordinate if takeable?(at_square)
      end

      moves
    end
    
    # The rank that the pawn starts in in a traditional board setup.
    # @return [Integer]
    def starting_rank
      Pawn.starting_ranks[color]
    end

    # The 'y' direction that the pawn moves in. (1 for white, -1 for black)
    # @return [Integer]
    def rank_direction
      Pawn.rank_directions[color]
    end

    private

    def takeable?(variable)
      variable.kind_of?(Piece) && variable.color == opposite_color 
    end

    def takeable_coordinates(position)
      [
        position.relative_coordinate(1, rank_direction),
        position.relative_coordinate(-1, rank_direction)
      ].reject { |m| impossible_coordinate?(m) }
    end
  end
end
