module RubyChessBoard
  # Contains methods that help to identify types of coordinates.
  module CoordinateHelpers
    private
    
    # Returns true if the subject is an empty square.
    # @return [Boolean]
    def empty_square?(subject)
      subject.kind_of?(BoardFile::EmptySquare)
    end
    
    # Returns true if the subject is an impossible coordinate.
    # @return [Boolean]
    def impossible_coordinate?(subject)
      subject.kind_of?(Coordinate::ImpossibleCoordinate)
    end
  end
end
