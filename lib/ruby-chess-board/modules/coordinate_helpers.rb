module RubyChessBoard
  module CoordinateHelpers
    private
    
    # Returns true if the variable is an empty square.
    # @return [Boolean]
    def empty_square?(variable)
      variable.kind_of?(BoardFile::EmptySquare)
    end
    
    # Returns true if the variable is an impossible coordinate.
    # @return [Boolean]
    def impossible_coordinate?(variable)
      variable.kind_of?(Coordinate::ImpossibleCoordinate)
    end
  end
end
