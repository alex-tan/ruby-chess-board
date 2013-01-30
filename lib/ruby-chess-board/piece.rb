module RubyChessBoard
  class Piece
    class <<self
      # Colors a piece can be.
      # @return [Array<Symbol>]
      def colors
        [:white, :black]
      end
    end

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
    
    # Returns a coordinate collection made up of individual coordinates and/or coordinate sets
    # in which the piece can hypothetically move. This still may include moves which are
    # blocked or occupied by pieces of the same color.
    # @param [Game] game
    # @return [CoordinateCollection]
    def directional_moves(game)
      moves = raw_directional_moves(game)
      moves.compact
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

    # Returns true if the variable is a Piece and its color is the opposite.
    # @return [Boolean]
    def opponent?(variable)
      variable.kind_of?(Piece) && variable.color == opposite_color 
    end

    # Returns true if the variable is a Piece and its color is the same.
    # @return [Boolean]
    def ally?(variable)
      variable.kind_of?(Piece) && variable.color == color
    end
  end
end
