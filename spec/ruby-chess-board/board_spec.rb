require 'spec_helper'

module RubyChessBoard
  describe Board do
    subject(:board) { Board.new }

    describe "initialization" do
      context "when no board is provided" do
        it "sets up the board" do
          expect(board.a1).to be_piece(Rook).with_color(:white).with_starting_position(:a1)
          expect(board.b1).to be_piece(Knight).with_color(:white).with_starting_position(:b1)
          expect(board.c1).to be_piece(Bishop).with_color(:white).with_starting_position(:c1)
          expect(board.d1).to be_piece(Queen).with_color(:white).with_starting_position(:d1)
          expect(board.e1).to be_piece(King).with_color(:white).with_starting_position(:e1)
          expect(board.f1).to be_piece(Bishop).with_color(:white).with_starting_position(:f1)
          expect(board.g1).to be_piece(Knight).with_color(:white).with_starting_position(:g1)
          expect(board.h1).to be_piece(Rook).with_color(:white).with_starting_position(:h1)
          ('a'..'h').each do |letter|
            square = letter + '2'
            expect(board.public_send(square)).to be_piece(Pawn).
              with_color(:white).
              with_starting_position(square)
          end

          expect(board.a8).to be_piece(Rook).with_color(:black).with_starting_position(:a8)
          expect(board.b8).to be_piece(Knight).with_color(:black).with_starting_position(:b8)
          expect(board.c8).to be_piece(Bishop).with_color(:black).with_starting_position(:c8)
          expect(board.d8).to be_piece(Queen).with_color(:black).with_starting_position(:d8)
          expect(board.e8).to be_piece(King).with_color(:black).with_starting_position(:e8)
          expect(board.f8).to be_piece(Bishop).with_color(:black).with_starting_position(:f8)
          expect(board.g8).to be_piece(Knight).with_color(:black).with_starting_position(:g8)
          expect(board.h8).to be_piece(Rook).with_color(:black).with_starting_position(:h8)
          ('a'..'h').each do |letter|
            square = letter + '7'
            expect(board.public_send(square)).to be_piece(Pawn).
              with_color(:black).
              with_starting_position(square)
          end

          (3..6).each do |file|
            ('a'..'h').each do |rank|
              expect(board.public_send(rank + file.to_s)).to be_nil
            end
          end
        end
      end
    end
  end
end
