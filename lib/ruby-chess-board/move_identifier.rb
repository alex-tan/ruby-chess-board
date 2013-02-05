module RubyChessBoard
  # Identifies PGN Move notation.
  # @example
  #   identifier = MoveIdentifier.new
  #   identifier.identify('Kxe4')
  #   identifier.piece_type  # Knight
  #   identifier.move_type   # :capture
  #   identifier.destination # :e4
  class MoveIdentifier
    # @return [Symbol] the square name where the piece is moving.
    attr_reader :destination

    # @return [Symbol] the file where the piece is moving from.
    attr_reader :file

    # @return [Symbol] the type of move, either :normal, :capture, :queenside_castle,
    #   promotion, or :kingside_castle.
    attr_reader :move_type

    # @return [Piece] the class of piece being promoted to.
    attr_reader :promotion_piece_type

    # @return [Piece, Array<Piece>] the class or classes of pieces moving.
    attr_reader :piece_type
    
    # @return [Integer] the rank the piece is moving from.
    attr_reader :rank
      
    # Identifies PGN move notation and returns the instance with all possible
    # information attached.
    # @param [String] move
    # @return [MoveIdentifier]
    def identify(move)
      set_qualities move_qualities(move)
      self.clone 
    end

    private

    PIECE_MAP = {
      'K' => King,
      'Q' => Queen,
      'R' => Rook,
      'B' => Bishop,
      'N' => Knight
    }

    PIECE_LETTER           = "[#{PIECE_MAP.keys.join('|')}]{0,1}"
    PROMOTION_PIECE_LETTER = "[B|N|R|Q]"
    FILE                   = "[a-h]"
    RANK                   = "[1-8]"
    CAPTURE                = "x{0,1}"
    SQUARE                 = [FILE, RANK].join('')

    def move_qualities(move)
      case move
      when 'O-O'
        {
          move_type: :kingside_castle,
          piece_type: [King, Rook]
        }
      when 'O-O-O'
        {
          move_type:  :queenside_castle,
          piece_type: [King, Queen]
         }
      when pattern = /(#{SQUARE})=(#{PROMOTION_PIECE_LETTER})/
        destination, promotion_piece = identifiables_from_move(move, pattern) 

        {
          destination:           destination.to_sym,
          move_type:             :promotion,
          piece_type:            Pawn,
          promotion_piece_type:  identify_piece(promotion_piece)
        }
      when pattern = /(#{PIECE_LETTER})(#{FILE})(#{RANK})(#{CAPTURE})(#{SQUARE})/
        piece, file, rank, capture, destination = identifiables_from_move(move, pattern)

        { destination:  destination.to_sym,
          file:         file.to_sym,
          piece_type:   identify_piece(piece),
          move_type:    identify_move_type(capture)
        }
      when pattern = /(#{PIECE_LETTER})(#{RANK})(#{CAPTURE})(#{SQUARE})/
        piece, rank, capture, destination = identifiables_from_move(move, pattern)

        {
          destination:   destination.to_sym,
          move_type:     identify_move_type(capture),
          piece_type:    identify_piece(piece),
          rank:          rank.to_i
        }
      when pattern = /(#{PIECE_LETTER})(#{FILE})(#{CAPTURE})(#{SQUARE})/
        piece, file, capture, destination = identifiables_from_move(move, pattern)

        {
          destination: destination.to_sym,
          file:        file.to_sym,
          move_type:   identify_move_type(capture),
          piece_type:  identify_piece(piece)
        }
      when pattern = /(#{PIECE_LETTER})(#{SQUARE})/
        piece, destination = identifiables_from_move(move, pattern) 

        {
          destination: destination.to_sym,
          move_type:   :normal,
          piece_type:  identify_piece(piece)
        }
      else raise "Could not identify move #{move}"
      end
    end

    def set_qualities(options = {})
      @destination          = options[:destination]
      @file                 = options[:file]
      @move_type            = options[:move_type]
      @piece_type           = options[:piece_type]
      @promotion_piece_type = options[:promotion_piece_type]
      @rank                 = options[:rank]
    end

    def identifiables_from_move(move, pattern)
      move.scan(pattern).flatten
    end

    def identify_move_type(capture)
      capture.empty? ? :normal : :capture
    end

    def identify_piece(piece_notation)
      if piece_notation
        piece_notation.empty? ? Pawn : PIECE_MAP[piece_notation]
      end
    end
  end
end

