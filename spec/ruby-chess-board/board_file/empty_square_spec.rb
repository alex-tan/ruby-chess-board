# typed: false
require 'spec_helper'

module RubyChessBoard
  describe BoardFile::EmptySquare do
    subject(:square) { build(:empty_square) }

    describe "equality testing" do
      it "is equal to any other empty square" do
        square_2 = build(:empty_square) 
        expect(square).to eq(square_2)
      end

      it "is not equal to things that are not empty squares" do
        pawn = build(:pawn)
        expect(square).to_not eq(pawn)
      end
    end
  end
end
