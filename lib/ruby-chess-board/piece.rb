module RubyChessBoard
  class Piece
    attr_reader :color, :starting_position

    def initialize(options = {})
      @color             = options[:color]
      @starting_position = options[:starting_position]
    end
  end
end
