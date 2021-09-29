# typed: false
require 'spec_helper'

module RubyChessBoard
  describe Knight do
    it_should_behave_like 'a chess piece'

    describe "raw directional moves" do
      let(:game) { build(:game, boards: boards) }
      let(:boards) do
        board = build(:board)
        board.move_piece(:b1, :d4)
        [board]
      end
      
      it "returns all coordinates an L-move away" do
        knight = game.board.d4
        expected = build :coordinate_collection,
          coordinates: coordinate_array(:e6, :f5, :f3, :e2, :c2, :b3, :b5, :c6)
        expect(knight.raw_directional_moves(game)).to eq(expected)
      end
    end
  end
end
