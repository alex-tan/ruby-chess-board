# encoding: UTF-8
module RubyChessBoard
  class BoardPrinter
    attr_reader :board

    def initialize(board)
      @board = board
    end

    def print
      Terminal::Table.new do |table|
        Board.rank_names.reverse.each do |rank|
          table << [rank] + Board.file_names.map do |file|
            icon(board.at_square("#{file}#{rank}"))
          end
           
          table << :separator
        end

        table << [nil] + Board.file_names
      end
    end
    
    # Returns the icon character representation of a piece or empty
    # square.
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
