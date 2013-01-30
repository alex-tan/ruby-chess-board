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
    
    # Returns a deep clone of itself.
    # @return [CoordinateCollection]
    def clone
      Marshal::load(Marshal.dump(self))
    end
    
    # Returns a new CoordinateCollection that has no empty sets and
    # no impossible coordinates.
    # @return [CoordinateCollection]
    def compact
      collection = clone
      collection.remove_empty_sets
      collection.remove_impossible_coordinates
      collection
    end

    # Removes empty sets from the collection.
    # @return [void]
    def remove_empty_sets
      @sets.reject!(&:empty?)
    end
    
    # Removes impossible coordinates from the collection.
    # @return [void]
    def remove_impossible_coordinates
      @coordinates.reject! { |c| impossible_coordinate?(c) }
    end
  end
end
