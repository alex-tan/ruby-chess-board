module RubyChessBoard
  module CoordinateHelpers
    
    private

    def impossible_coordinate?(variable)
      variable.kind_of?(BoardCoordinate::ImpossibleCoordinate)
    end
  end
end
