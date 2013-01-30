module RubyChessBoard
  class CoordinateCollection
    include CoordinateHelpers

    # @option options [Array] :coordinates
    # @option options [Array] :sets
    def initialize(options = {})
      @coordinates = options[:coordinates] || []
      @sets        = options[:sets] || []
    end

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
    
    # Removes sets that are empty and coordinates that are impossible.
    # @return [void]
    def compact
      remove_empty_sets
      remove_impossible_coordinates
    end

    private

    def remove_empty_sets
      @sets.reject!(&:empty?)
    end

    def remove_impossible_coordinates
      @coordinates.reject! { |c| impossible_coordinate?(c) }
    end
  end
end
