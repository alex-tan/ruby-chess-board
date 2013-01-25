module RubyChessBoard
  class Piece
    attr_reader :color, :starting_position

    def initialize(options = {})
      @color             = options[:color].to_sym
      @starting_position = options[:starting_position].to_sym
    end
    
    # Pieces are equal if their color and starting
    def ==(piece)
      color             == piece.color &&
      starting_position == piece.starting_position &&
      self.class        == piece.class
    end

    def directional_moves(board)
      raw_directional_moves(board).reject do |move_or_set|
        empty_set?(move_or_set) || impossible_coordinate?(move_or_set)
      end
    end

    def opposite_color
      if    white? then :black
      elsif black? then :white
      end
    end

    def white?
      color == :white
    end

    def black?
      color == :black
    end

    private

    def impossible_coordinate?(variable)
      variable.kind_of?(BoardCoordinate::ImpossibleCoordinate)
    end

    def empty_set?(variable)
      variable.kind_of?(Array) && variable.empty?
    end
  end
end
