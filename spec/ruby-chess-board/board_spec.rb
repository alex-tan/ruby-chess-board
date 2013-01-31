require 'spec_helper'

module RubyChessBoard
  describe Board do
    subject(:board) { Board.new }

    describe "initialization" do
      context "when a board is provided" do
        let(:new_board) { Board.new(board) }

        it "mirrors the board" do
          board.move_piece(:a2, :a4)

          expect(new_board.a2).to be_empty_square
          expect(new_board.a4).to be_piece(Pawn).with_color(:white).with_starting_position(:a2)
        end

        it "does not affect the origin board" do
          new_board.move_piece(:a2, :a4)          

          expect(board.a4).to be_empty_square
        end
      end

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
              expect(board.public_send(rank + file.to_s)).to be_empty_square
            end
          end
        end
      end
    end

    describe "#coordinates_of" do
      context "when the piece is on the board" do
        it "returns the board coordinate of the piece provided" do
          rook = board.a1

          expected = Coordinate.new(:a1)

          expect(board.coordinates_of(rook)).to eq(expected)
        end
      end

      context "when the piece isn't on the board" do
        it "returns nil" do
          rook = board.a1

          board.a1 = nil

          expect(board.coordinates_of(rook)).to eq(nil)
        end
      end
    end

    describe "#move_piece" do
      def run_method
        board.move_piece(:a2, :a4)
      end

      it "makes the old square empty" do
        expect {
          run_method
        }.to change { board.a2 }

        expect(board.a2).to be_empty_square
      end

      it "moves the piece to the new square" do
        expect { run_method }.to change { board.a4 }

        expect(board.a4).to be_piece(Pawn).with_color(:white).with_starting_position(:a2)
      end
    end

    describe "#at_square" do
      context "when a piece occupies a square" do
        it "returns the piece" do
          expect(board.a1).to be_kind_of(Rook) 
        end
      end

      context "when no piece occupies a square" do
        it "returns EmptySquare" do
          expect(board.g5).to be_empty_square
        end
      end
    end

    describe "#set_square" do
      it "given a square name and a value, sets that square" do
        board.set_square(:a2, nil)
        expect(board.a2).to be_empty_square

        pawn = board.d2
        board.set_square(:c3, pawn)

        expect(board.c3).to eq(pawn)
      end
    end
  end
end
