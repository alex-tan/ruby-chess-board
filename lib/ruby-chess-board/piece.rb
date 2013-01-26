module RubyChessBoard
  class Piece
    # @return [Symbol] either :white or :black
    attr_reader :color

    # @return [Symbol] the square name that the piece started at
    attr_reader :starting_position
    
    # @option options [Symbol] :color can be :white or :black
    # @option options [Symbol] :starting_position can be a square name e.g. :a1.
    #   Used to differentiate it from other pieces of its type.
    def initialize(options = {})
      @color             = options[:color].to_sym
      @starting_position = options[:starting_position].to_sym
    end
    
    # Pieces are equal if their class, color, and starting position are
    # the same.
    # @return [Boolean]
    def ==(piece)
      self.class        == piece.class &&
      color             == piece.color &&
      starting_position == piece.starting_position
    end
    
    # Returns an array of coordinates and/or coordinate sets in
    # which the piece can move assuming there are no pieces in the way
    # and the move would not put the player in check.
    # @param [Game] game
    # @return [Array]
    def directional_moves(game)
      raw_directional_moves(game).reject do |move_or_set|
        empty_set?(move_or_set) || impossible_coordinate?(move_or_set)
      end
    end
  
    # Returns the opposite color of the Piece.
    # @return [Symbol] either :white or :black
    def opposite_color
      if    white? then :black
      elsif black? then :white
      end
    end
    
    # Returns true if the piece is white.
    # @return [Boolean]
    def white?
      color == :white
    end
    
    # Returns true if the piece is black.
    # @return [Boolean]
    def black?
      color == :black
    end

    private
        
    def impossible_coordinate?(variable)
      variable.kind_of?(BoardCoordinate::ImpossibleCoordinate)
    end

    def empty_set?(variable)
      variable.kind_of?(Array) && variable.empty?
    end
  end
end
