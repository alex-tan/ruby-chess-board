module RubyChessBoard
  class Board
    class BoardFiles
      def initialize
        @files = Array.new(8) { BoardFile.new }
      end

      def file(file_name)
        file_name = file_name.to_sym
        file_index = FILE_NAMES.index(file_name)

        @files[file_index]
      end
    end

    class BoardFile
      def initialize
        @ranks = Array.new(8)
      end

      def rank(rank_number)
        rank_index = rank_index(rank_number)
        @ranks[rank_index]
      end

      def set_rank(rank_number, value)
        rank_index = rank_index(rank_number) 
        @ranks[rank_index] = value
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

    def setup
      setup_piece :white, Rook,   :a1
      setup_piece :white, Knight, :b1
      setup_piece :white, Bishop, :c1
      setup_piece :white, Queen,  :d1
      setup_piece :white, King,   :e1
      setup_piece :white, Bishop, :f1
      setup_piece :white, Knight, :g1
      setup_piece :white, Rook,   :h1

      FILE_NAMES.each { |f| setup_piece :white, Pawn, "#{f}2" }

      setup_piece :black, Rook,   :a8
      setup_piece :black, Knight, :b8
      setup_piece :black, Bishop, :c8
      setup_piece :black, Queen,  :d8
      setup_piece :black, King,   :e8
      setup_piece :black, Bishop, :f8
      setup_piece :black, Knight, :g8
      setup_piece :black, Rook,   :h8

      FILE_NAMES.each { |f| setup_piece :black, Pawn, "#{f}7" }
    end

    # Returns the value of a square, i.e. a1, h8.
    def at_square(square_name)
      file, rank = file_and_rank(square_name)

      @files.file(file).rank(rank)
    end

    # Sets the value of a square, i.e. a1, h8.
    def set_square(square_name, value)
      file, rank = file_and_rank(square_name)
      @files.file(file).set_rank(rank, value)
    end

    private
    
    def file_and_rank(square_name)
      square_name = square_name.to_s
      file, rank  = square_name.split('')

      file = file.to_sym
      rank = rank.to_i

      return file, rank
    end

    def setup_piece(color, piece_class, square_name)
      piece = piece_class.new(color, square_name)

      set_square(square_name, piece)
    end

    def method_missing(method, *args)
      case method
      when pattern = /^[a-h][1-8]$/
        at_square(method)
      when pattern = /^[a-h][1-8]=$/
        square = method.gsub("=", '')
        set_square(method, *args)
      else super
      end
    end
  end
end
