module RubyChessBoard
  class CoordinateCollection
    # The array of CoordinateSets.
    # @return [Array<CoordinateSet]
    attr_accessor :sets

    # The array of BoardCoordinates.
    # @return [Array<BoardCoordinate>]
    attr_accessor :coordinates
    
    # Collections are equal if their sets and coordinates are the same.
    # @param [CoordinateCollection] collection
    # @return [Boolean]
    def ==(collection)
      collection.kind_of?(CoordinateCollection) &&
        collection.sets == sets &&
        collection.coordinates == coordinates
    end
  end
end
