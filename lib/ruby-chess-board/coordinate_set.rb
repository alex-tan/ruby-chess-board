module RubyChessBoard
  class CoordinateSet
    attr_reader :coordinates

    def initialize(coordinates)
      @coordinates = coordinates  
    end
    
    # CoordinateSets are equal when they have the same coordinates
    # in the same order.
    # @return [Boolean]
    def ==(coordinate_set)
      coordinate_set.kind_of?(CoordinateSet) &&
        coordinates == coordinate_set.coordinates 
    end
    
    # Returns a coordinate set with blocked spaces removed.
    # If the path is blocked by an ally, it will include all spaces before
    # it reaches that ally. If the path is blocked by an opponent, it will
    # include all spaces up to and including the one occupied by the opponent.
    # @option options [Game] :game the game, which must be set to the move we're
    #   testing at
    # @option options [Piece] :piece the piece we're testing to see whether it 
    #   can move in the direction of the coordinate set.
    # @return [CoordinateSet]
    def without_blocks(options)
      game  = options[:game]
      piece = options[:piece]

      board = game.board
      
      coordinates.each_with_index do |coordinate, index|
        at_position = board.at_square(coordinate.square_name)
        
        # Blocked by an opponent. Include this space.
        if piece.opponent?(at_position)
          return set_including_index(index)
        # Blocked by an ally. Do not include this space.
        elsif piece.ally?(at_position)
          return set_before_index(index)
        end
      end

      self
    end

    private

    def set_including_index(index)
      CoordinateSet.new(coordinates.take(index + 1))
    end

    def set_before_index(index)
      CoordinateSet.new(coordinates.take(index))
    end
  end
end
