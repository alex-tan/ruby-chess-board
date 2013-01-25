module RubyChessBoard
  # Represents a single file made up of 8 ranks.
  class BoardFile
    # Instances of this class are used to represent an empty square.
    EmptySquare = Class.new

    include Enumerable

    attr_reader :ranks
    
    def initialize
      @ranks = Array.new(8)
    end
    
    # Returns true if any of its ranks contain a piece.
    # @return [Boolean]
    def has_piece?(piece)
      find { |rank| rank == piece }
    end
    
    # Yields the value of each of the ranks, starting with 1,
    # up through 8.
    # @yield [rank]
    def each
      ranks.each { |rank| yield rank }
    end
    
    # Returns either a piece if there is something at a square.
    # Returns an instance of {EmptySquare} otherwise.
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
