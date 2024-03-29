# typed: true
module RubyChessBoard
  # A pawn chess piece.
  class Pawn < Piece
    include CoordinateHelpers

    class <<self
      # Returns the starting ranks of each colored pawn.
      # @return [Hash]
      def starting_ranks
        { white: 2, black: 7 }
      end
      
      # Returns the rank directions of each colored pawn.
      # @return [Hash]
      def rank_directions
        { white: 1, black: -1 }
      end
    end

    # @private
    def raw_directional_moves(game)
      board    = game.board
      position = coordinates_in_game(game)
      
      collection = CoordinateCollection.new

      # If the pawn is in the starting rank, then they can move forward either one
      # square or two.
      if position.rank == starting_rank 
        collection.sets << position.relative_coordinate_set(0, rank_direction, limit: 2)
      # Otherwise they only move one square at a time.
      else
        collection.coordinates << position.relative_coordinate(0, rank_direction)
      end
      
      # Check to see if there are pieces to take one square forward in each
      # adjoining file.
      takeable_coordinates(position).each do |coordinate|
        at_square = board.at_square(coordinate.square_name)
        collection.coordinates << coordinate if opponent?(at_square) 
      end

      collection.coordinates += en_passant_opportunities(game)

      collection
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
    
    # Returns an array of potential en passant opportunities.
    # @return [Array]
    def en_passant_opportunities(game)
      identifier = EnPassantIdentifier.new(game: game, capturing_pawn: self)
      identifier.opportunities
    end
    
    # Returns an array of 1-2 squares that may contain pieces the pawn can take.  
    # @return [Array<Coordinate>]
    def takeable_coordinates(position)
      [
        position.relative_coordinate(1, rank_direction),
        position.relative_coordinate(-1, rank_direction)
      ].reject { |c| impossible_coordinate?(c) }
    end
  end
end
