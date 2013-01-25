require 'spec_helper'

module RubyChessBoard
  describe BoardFile::EmptySquare do
    subject(:square) { BoardFile::EmptySquare.new }

    describe "equality testing" do
      it "is equal to any other empty square" do
        square_2 = BoardFile::EmptySquare.new

        expect(square).to eq(square_2)
      end

      it "is not equal to other pieces" do
        pawn = build(:pawn)

        expect(square).to_not eq(pawn)
      end
    end
  end
end
