module RubyChessBoard
  # Identifies when an en passant move is possible. Each instance of the class is meant to
  # be used only once.
  class EnPassantIdentifier
    attr_reader :game, :capturing_pawn
    # @option options [Game] :game the game at the state in which we're checking for
    #   en passant opportunities
    # @option options [Pawn] :capturing_pawn the pawn that is potentially doing the
    #   capturing
    def initialize(options)
      @game           = options[:game]
      @capturing_pawn = options[:capturing_pawn]
    end
    
    # Returns an array of board coordinates that can be taken en passant.
    # @return [Array<BoardCoordinate>]
    def opportunities
      opportunities = []

      adjacent_files.each do |file|
        opportunities << capturable_position(file: file) if opportunity_in_file?(file)
      end

      opportunities
    end

    # The coordinate the pawn can take at if an en passant is possible.
    # @options options [Symbol] :file
    # @return [BoardCoordinate]
    def capturable_position(options)
      file = options[:file]
      rank = current_position.rank + capturing_pawn.rank_direction

      BoardCoordinate.new(file, rank)
    end
    
    # Returns true if the capturing pawn can en passant in the file provided.
    # @param file [Symbol] file
    # @return [Boolean]
    def opportunity_in_file?(file)
      game_has_started? &&
        capturing_pawn_at_its_fifth_rank? &&
        opponent_pawn_in_same_rank_at_file?(file) &&
        opponent_pawn_was_in_starting_rank_last_move_at_file?(file)
    end

    # Returns true if the game's move is greater than 0.
    # @return [Boolean]
    def game_has_started?
      game.move > 0
    end

    # Returns true if the capturing pawn is at its fifth rank.
    # @return [Boolean]
    def capturing_pawn_at_its_fifth_rank?
      fifth_rank = capturing_pawn.starting_rank + (3 * capturing_pawn.rank_direction)

      current_position.rank == fifth_rank
    end

    # Returns true if there is an opposite color pawn in the same rank as the
    # capturing pawn and in the file specified.
    # @param [Symbol] file
    # @return [Boolean]
    def opponent_pawn_in_same_rank_at_file?(file)
      board     = game.board
      at_square = board.at_square("#{file}#{current_position.rank}")
      opponent_pawn?(at_square)
    end

    # Returns true if there was an opposite color pawn in the file specified last
    # move at its starting rank.
    # @param [Symbol] file
    # @return [Boolean]
    def opponent_pawn_was_in_starting_rank_last_move_at_file?(file)
      board     = board_at_last_move
      at_square = board.at_square("#{file}#{opponent_pawn_starting_rank}")
      opponent_pawn?(at_square)
    end

    # The starting rank of opponent pawns.
    # @return [Integer]
    def opponent_pawn_starting_rank
      color = capturing_pawn.opposite_color
      Pawn.starting_ranks[color]
    end

    # The previous board state in the game.
    # @return [Board]
    def board_at_last_move
      game.board_at_move(game.move - 1)
    end

    # Returns true if the argument is a type of pawn and is the opposite color
    # of the capturing pawn.
    # @return [Boolean]
    def opponent_pawn?(variable)
      variable.kind_of?(Pawn) && capturing_pawn.can_take?(variable) 
    end

    # The current position of the capturing pawn.
    # @return [BoardCoordinate]
    def current_position
      board = game.board
      board.coordinates_of(capturing_pawn)
    end
    
    # Returns an array af adjacent files from the current position.
    # @return [Array<Symbol>]
    def adjacent_files
      current_position.adjacent_files
    end
  end
end
