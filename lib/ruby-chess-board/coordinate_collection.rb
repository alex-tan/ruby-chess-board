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
    
    # Clones the collection with individual coordinates blocked by allies of the piece
    # as well as blocked parts of its coordinate sets. 
    # @option [Piece] :piece - the piece from whose perspective we're checking for blocks
    # @option [Game] :game - a game set to the state from which to check for blocks 
    # @return [CoordinateCollection]
    def without_blocks(options)
      piece = options[:piece]
      game  = options[:game]

      collection = clone
      collection.sets.map! { |set| set.without_blocks(piece: piece, game: game) }
      collection.without_individual_blocks!(piece: piece, game: game)
      collection
    end
    
    # Removes individual coordinates that are blocked by allies of the piece
    # provided from self.
    # @option [Piece] :piece - the piece from whose perspective we're checking for blocks
    # @option [Game] :game - a game set to the state from which to check for blocks 
    # @return [void]
    def without_individual_blocks!(options)
      piece = options[:piece]
      game  = options[:game]
      board = game.board

      coordinates.reject! do |coordinate|
        at_position = board.at_square(coordinate.square_name) 
        piece.ally?(at_position) 
      end
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
