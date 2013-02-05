module RubyChessBoard
  # Represents a single file made up of 8 ranks.
  class BoardFile
    # Used to represent an empty square on a {Board}
    class EmptySquare
      include CoordinateHelpers

      # An empty square only equals other empty squares.
      # @return [Boolean]
      def ==(subject)
        empty_square?(subject)
      end
    end

    include Enumerable
    
    # TODO: Replace direct access to avoid accessing nils rather
    # than empty squares.
    # @private
    attr_reader :ranks

    def initialize
      @ranks = Array.new(8)
    end
    
    # Returns true if any of its ranks contain a piece.
    # @return [Boolean]
    def has_piece?(piece)
      find { |rank| rank == piece }
    end
    
    # @private
    def each
      ranks.each { |rank| yield rank || EmptySquare.new }
    end

    # Yields the value of each of the ranks, starting with 1,
    # up through 8.
    # @yield [rank]
    alias_method :each_rank, :each
    
    # Returns either a piece if there is something at a square or
    # returns an instance of {EmptySquare} if there is not.
    # @return [Piece, EmptySquare]
    def at_rank(rank_number)
      rank_index = rank_index(rank_number)
      ranks[rank_index] || EmptySquare.new
    end
    
    # Given a rank number and a value, sets the rank.
    # @return [void]
    def set_rank(rank_number, value)
      rank_index = rank_index(rank_number) 
      @ranks[rank_index] = value
    end

    private
    
    # Converts a rank to an array number.
    def rank_index(rank_number)
      rank_number.to_i - 1
    end
  end
end
