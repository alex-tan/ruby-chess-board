require 'spec_helper'

module RubyChessBoard
  describe Pawn do
    let(:board) { build(:board) }
    subject(:pawn) { build(:pawn) }

    it_should_behave_like 'a chess piece'

    describe "raw directional moves" do
      context "when the piece is white" do
        subject(:pawn) { board.d2 }

        context "when it's in the second rank" do
          it "can move forward one or two" do
            expected_moves = [coordinates(:d3, :d4)]
            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end 

        context "when it's in the third through seventh ranks" do
          it "can move forward one" do
            pawn # have to load the piece before it's moved
            board.move_piece(:d2, :d3)
            expected_moves = coordinates(:d4) 
            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end

        context "when there are opposite color pieces in the forward adjoining files" do
          it "can take those pieces" do
            board.move_piece(:f8, :e3)
            board.move_piece(:d8, :c3)

            expected_moves = [
              coordinates(:d3, :d4),
            ] + coordinates(:e3, :c3)

            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end

        context "when there are same color pieces in the forward adjoining files" do
          it "cannot take those pieces" do
            board.move_piece(:a1, :e3)
            board.move_piece(:h1, :c3)

            expected_moves = [coordinates(:d3, :d4)]
            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end 
        end

        context %(when a black piece moved forward two places the last move and
                  is in the same rank and an adjoining file) do
          it "can take en passant" do
            pending('Game class')
          end
        end
      end

      context "when the piece is black" do
        subject(:pawn) { board.e7 }

        context "when it's in the seventh rank" do
          it "can move down one or two ranks" do
            expected_moves = [coordinates(:e6, :e5)]

            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end

        context "when it's in the sixth through second ranks" do
          it "can move down one rank at a time" do
            pawn # load piece before it's moved
            board.move_piece(:e7, :e6)
            expected_moves = coordinates(:e5) 
            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end

        context "when there are opposite color pieces in the forward adjoining files" do
          it "can take those pieces" do
            board.move_piece(:a1, :d6)
            board.move_piece(:g1, :f6)

            expected_moves = [
              coordinates(:e6, :e5),
            ] + coordinates(:f6, :d6)

            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end
        end

        context "when there are same color pieces in the forward adjoining files" do
          it "cannot take those pieces" do
            board.move_piece(:f8, :d6)
            board.move_piece(:h8, :f6)

            expected_moves = [coordinates(:e6, :e5)]

            expect(pawn.raw_directional_moves(board)).to eq(expected_moves)
          end 
        end

        context %(when a white piece moved forward two places the last move and
                  is in the same rank and an adjoining file) do
          it "can take en passant" do
            pending('Game class.')
          end
        end
      end
    end
  end
end

