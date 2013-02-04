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
    
    # Returns the board representation as a string.
    # @return [String]
    def print
      BoardPrinter.new(self).print
    end

    attr_reader :files
    
    # Returns the Coordinate of the piece provided if it
    # is on the board; otherwise returns nil.
    # @param [Piece] piece
    # @return [Coordinate, nil]
    def coordinates_of(piece)
      file = files.find { |f| f.has_piece?(piece) }
      
      return nil if file.nil?

      x = files.index(file)
      y = file.ranks.index(piece)

      Coordinate.new(x, y)
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
     
    # Returns all pieces of a given color.
    # @param [Symbol] color :white or :black
    def pieces(color)
      files.pieces(color)
    end
    
    Board.file_names.each do |file|
      Board.rank_names.each do |rank|
        square = "#{file}#{rank}"
         
        define_method(square) do
          at_square(square)
        end

        define_method("#{square}=") do |value|
          set_square(square, value)
        end
      end
    end
    
    private

    def file_and_rank(square_name)
      square_name = square_name.to_s
      file, rank  = square_name.split('')

      file = file.to_sym
      rank = rank.to_i

      return file, rank
    end
  end
end
