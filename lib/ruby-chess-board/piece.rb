module RubyChessBoard
  class Piece
    attr_reader :color, :starting_position

    def initialize(options = {})
      @color             = options[:color].to_sym
      @starting_position = options[:starting_position].to_sym
    end
  end
end
