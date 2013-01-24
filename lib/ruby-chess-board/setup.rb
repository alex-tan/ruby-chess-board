module RubyChessBoard
  class Board
    class Setup
      MAJOR_PIECE_POSITIONS = {
        white: {
          a1: Rook,
          b1: Knight,
          c1: Bishop,
          d1: Queen,
          e1: King,
          f1: Bishop,
          g1: Knight,
          h1: Rook
        },

        black: {
          a8: Rook,
          b8: Knight,
          c8: Bishop,
          d8: Queen,
          e8: King,
          f8: Bishop,
          g8: Knight,
          h8: Rook
        }
      }

      PAWN_RANKS = {
        white: 2,
        black: 7
      }

      def initialize(options = {})
        @board = options[:board]
      end

      attr_reader :board

      def setup
        MAJOR_PIECE_POSITIONS.each do |color, positions|
          positions.each do |position, piece_class|
            setup_piece piece_class, color: color, starting_position: position
          end
        end
        
        PAWN_RANKS.each do |color, rank|
          Board.file_names.each do |file|
            square = "#{file}#{rank}"
            setup_piece Pawn, color: color, starting_position: square
          end
        end
      end

      private

      def setup_piece(piece_class, options = {})
        piece = piece_class.new color:             options[:color],
                                starting_position: options[:starting_position]

        @board.set_square(options[:starting_position], piece)
      end
    end
  end
end
