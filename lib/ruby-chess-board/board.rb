module RubyChessBoard
  class Board
    EmptySquare = Class.new
    
    class <<self
      def file_names
        ('a'..'h').map(&:to_sym)
      end

      def rank_names
        (1..8).to_a
      end
    end

    def initialize(board = nil)
      if board
        @files = board.files.clone
      else
        @files = BoardFiles.new
        setup
      end
    end

    attr_reader :files
    
    # Moves whatever is on one square to another.
    def move_piece(from, to)
      moving_piece = at_square(from)

      set_square(from, nil)
      set_square(to, moving_piece)
    end
    
    # Sets the chess board up.
    # @return [void]
    def setup
      Setup.new(board: self).setup
    end

    # Returns the value of a square, i.e. a1, h8.
    # @return [Piece, EmptySquare]
    def at_square(square_name)
      file, rank = file_and_rank(square_name)

      files[file].rank(rank) || EmptySquare.new
    end

    # Sets the value of a square, i.e. a1, h8.
    # @return [void]
    def set_square(square_name, value)
      file, rank = file_and_rank(square_name)
      files[file].set_rank(rank, value)
    end

    private
    
    def file_and_rank(square_name)
      square_name = square_name.to_s
      file, rank  = square_name.split('')

      file = file.to_sym
      rank = rank.to_i

      return file, rank
    end

    def method_missing(method, *args)
      method = method.to_s

      square = /[a-h][1-8]/
      case method
      when pattern = /^#{square}$/
        at_square(method)
      when pattern = /^#{square}=$/
        square = method.gsub("=", '')
        set_square(square, *args)
      else super
      end
    end
  end
end
