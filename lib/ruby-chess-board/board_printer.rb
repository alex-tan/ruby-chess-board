# encoding: UTF-8
module RubyChessBoard
  # Prints {Board} objects.
  class BoardPrinter
    include BoardReferences

    # The board that the printer was initialized with.
    # @return [Board]
    attr_reader :board
    
    # @param [Board] board the board that needs to be printed
    def initialize(board)
      @board = board
    end
    
    # Returns a string representation of the board.
    # @return [String]
    def print
      Terminal::Table.new do |table|
        # Print each rank number with each piece from rank 8
        # down to rank 1.
        rank_names.reverse.each do |rank|
          table << [rank] + file_names.map do |file|
            icon(board.at_square("#{file}#{rank}"))
          end
           
          table << :separator
        end
        
        # Print an row with an empty square and the file names.
        table << [nil] + Board.file_names
      end
    end
    
    # Returns the icon character representation of a piece or empty
    # square.
    # @param [Piece] piece
    # @return [String]
    def icon(piece)
      if piece.kind_of?(King)      then '♔'
      elsif piece.kind_of?(Queen)  then '♕'
      elsif piece.kind_of?(Rook)   then '♖'
      elsif piece.kind_of?(Bishop) then '♗'
      elsif piece.kind_of?(Knight) then '♘'
      elsif piece.kind_of?(Pawn)   then '♙'
      else '  '
      end
    end
  end
end
