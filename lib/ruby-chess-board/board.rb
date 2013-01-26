module RubyChessBoard
  class Board
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
    
    # Returns the BoardCoordinate of the piece provided if it
    # is on the board; otherwise returns nil.
    # @param [Piece] piece
    # @return [BoardCoordinate, nil]
    def coordinates_of(piece)
      file = files.find { |f| f.has_piece?(piece) }
      
      return nil if file.nil?

      x = files.index(file)
      y = file.ranks.index(piece)

      BoardCoordinate.new(x, y)
    end
    
    # Moves whatever is on one square to another.
    # @param [Symbol] from square name
    # @param [Symbol] to square name
    # @return [void]
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

      files[file].at_rank(rank)
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
      when /^#{square}$/
        at_square(method)
      when /^#{square}=$/
        square = method.gsub("=", '')
        set_square(square, *args)
      else super
      end
    end
  end
end
