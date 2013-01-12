module RubyChessBoard
  class Piece
    attr_reader :color, :starting_position

    def initialize(color, starting_position)
      @color             = color.to_sym
      @starting_position = starting_position.to_sym
    end
  end
end
