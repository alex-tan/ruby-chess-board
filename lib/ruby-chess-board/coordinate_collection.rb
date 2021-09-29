# typed: true
module RubyChessBoard
  # Encapsulates both a list of individual {Coordinate} objects and
  # a list of {CoordinateSet} objects.
  class CoordinateCollection
    include CoordinateHelpers, MarshalClone

    # @option options [Array] :coordinates
    # @option options [Array] :sets
    def initialize(options = {})
      @coordinates = options[:coordinates] || []
      @sets        = options[:sets]        || []
    end

    # The array of CoordinateSets.
    # @return [Array<CoordinateSet>]
    attr_accessor :sets

    # The array of Coordinates.
    # @return [Array<Coordinate>]
    attr_accessor :coordinates
    
    # Collections are equal if their sets and coordinates are the same.
    # @param [CoordinateCollection] collection
    # @return [Boolean]
    def ==(collection)
      collection.kind_of?(CoordinateCollection) &&
        collection.sets == sets &&
        collection.coordinates == coordinates
    end

    def include?(coordinate)
      coordinates.include?(coordinate) ||
        sets.any? { |set| set.include?(coordinate) }
    end
    
    # Clones the collection with individual coordinates blocked by allies of the piece
    # as well as blocked parts of its coordinate sets. 
    # @option [Piece] :piece - the piece from whose perspective we're checking for blocks
    # @option [Game] :game - a game set to the state from which to check for blocks 
    # @return [CoordinateCollection]
    def without_blocks(options)
      piece = options[:piece]
      game  = options[:game]

      clone.
        without_individual_blocks(piece: piece, game: game).
        without_set_blocks(piece: piece, game: game)
    end
    
    # Returns a new collection with individual coordinates that are occupied by allies
    # removed.
    # @option [Piece] :piece - the piece from whose perspective we're checking for blocks
    # @option [Game] :game - a game set to the state from which to check for blocks 
    # @return [CoordinateCollection]
    def without_individual_blocks(options)
      piece = options[:piece]
      game  = options[:game]
      board = game.board

      collection = clone

      collection.coordinates.reject! do |coordinate|
        at_position = board.at_square(coordinate.square_name) 
        piece.ally?(at_position) 
      end

      collection
    end
    
    # Returns a new collection with blocks in its sets removed.
    # @option [Piece] :piece - the piece from whose perspective we're checking for blocks
    # @option [Game] :game - a game set to the state from which to check for blocks 
    # @return [CoordinateCollection]
    def without_set_blocks(options)
      piece = options[:piece]
      game  = options[:game]

      collection = clone
      collection.sets.map! { |set| set.without_blocks(piece: piece, game: game) }
      collection
    end
    
    # Returns a new collection with empty sets removed.
    # @return [CoordinateCollection]
    def without_empty_sets
      collection = clone
      collection.sets.reject!(&:empty?)
      collection
    end
    
    # Returns a new collection with impossible coordinates removed.
    # @return [CoordinateCollection]
    def without_impossible_coordinates
      collection = clone
      collection.coordinates.reject! { |c| impossible_coordinate?(c) }
      collection
    end
  end
end
