module RubyChessBoard
  class Game
    class EndOfGame < Exception
    end

    class BeginningOfGame < Exception
    end

    attr_reader :move, :boards

    def initialize(boards)
      @boards = boards
      @move   = 0
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
    
    # Advances the game by 1 move.
    # @return [void]
    def forward
      raise EndOfGame if boards.last == board
      @move += 1
    end
    
    # Goes back in the game by 1 move.
    # @return [void]
    def back
      raise BeginningOfGame if boards.first == board
      @move -= 1
    end
  end
end
