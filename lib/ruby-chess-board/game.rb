# typed: true
module RubyChessBoard
  # Encapsulates an ordered list of {Board} objects, which join
  # to represent a chess game.
  class Game
    # An exception raised when an attempt to navigate past the
    # end of the game is made.
    class EndOfGame < Exception
    end
    
    # An exception raised when an attempt to navigate before
    # the beginning of the game is made.
    class BeginningOfGame < Exception
    end

    include MarshalClone

    attr_reader :move, :boards

    def initialize(boards)
      @boards = boards
      @move   = 0
    end

    # Returns the board at a given move number but does not change
    # the move the board is at.
    # @param [Integer] move_number
    # @return [Board]
    def board_at_move(move_number)
      boards[move_number]
    end
    
    # The number of moves in the game.
    # @return [Integer]
    def moves
      boards.size - 1
    end
    
    # The state of the board given the move the
    # game is at.
    # @return [Board]
    def board
      boards[move]
    end
    
    # Advances the game by 1 move and returns the board at that point.
    # @return [Board]
    def forward
      raise EndOfGame if boards.last == board
      go_to_move_and_return_board(move + 1)
    end
    
    # Goes back in the game by 1 move and returns the board at that point.
    # @return [Board]
    def back
      raise BeginningOfGame if boards.first == board
      go_to_move_and_return_board(move - 1)
    end
    
    # Goes to the very last move of the game and returns the board at that
    # point.
    # @return [Board]
    def last
      go_to_move_and_return_board(moves)
    end

    private

    def go_to_move_and_return_board(move_number)
      @move = move_number
      board
    end
  end
end
