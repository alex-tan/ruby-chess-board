module RubyChessBoard
  class Board
    class BoardFiles
      attr_reader :files

      def initialize
        @files = Array.new(8) { BoardFile.new }
      end

      def find(file_name)
        file_name = file_name.to_sym
        file_index = FILE_NAMES.index(file_name)

        files[file_index]
      end
    end

    class BoardFile
      attr_reader :ranks

      def initialize
        @ranks = Array.new(8)
      end

      def rank(rank_number)
        rank_index = rank_index(rank_number)
        ranks[rank_index]
      end

      def set_rank(rank_number, value)
        rank_index = rank_index(rank_number) 
        ranks[rank_index] = value
      end

      private

      def rank_index(rank_number)
        rank_number.to_i - 1
      end
    end

    FILE_NAMES = ('a'..'h').map(&:to_sym)
    RANK_NAMES = (1..8).to_a

    def initialize(board = nil)
      if board

      else
        @files = BoardFiles.new
        setup
      end
    end
    
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

    attr_reader :files

    def setup
      MAJOR_PIECE_POSITIONS.each do |color, positions|
        positions.each do |position, piece_class|
          setup_piece piece_class, color: color, starting_position: position
        end
      end
      
      PAWN_RANKS.each do |color, rank|
        FILE_NAMES.each do |file|
          square = "#{file}#{rank}"
          setup_piece Pawn, color: color, starting_position: square
        end
      end
    end

    # Returns the value of a square, i.e. a1, h8.
    def at_square(square_name)
      file, rank = file_and_rank(square_name)

      files.find(file).rank(rank)
    end

    # Sets the value of a square, i.e. a1, h8.
    def set_square(square_name, value)
      file, rank = file_and_rank(square_name)
      files.find(file).set_rank(rank, value)
    end

    private
    
    def file_and_rank(square_name)
      square_name = square_name.to_s
      file, rank  = square_name.split('')

      file = file.to_sym
      rank = rank.to_i

      return file, rank
    end

    def setup_piece(piece_class, options = {})
      piece = piece_class.new color:             options[:color],
                              starting_position: options[:starting_position]

      set_square(options[:starting_position], piece)
    end

    def method_missing(method, *args)
      case method
      when pattern = /^[a-h][1-8]$/
        at_square(method)
      when pattern = /^[a-h][1-8]=$/
        square = method.gsub("=", '')
        set_square(square, *args)
      else super
      end
    end
  end
end
