# typed: false
require 'spec_helper'

module RubyChessBoard
  describe Bishop do
    it_should_behave_like 'a chess piece' 

    describe "raw directional moves" do
      let(:game) { build(:game, boards: boards) }
      let(:boards) do
        board = build(:board) 
        board.move_piece(:c1, :d4)
        [board]
      end

      it "returns four relative sets from the current position" do
        bishop = game.board.d4

        expected = build :coordinate_collection, sets: [
          coordinate_set(:e5, :f6, :g7, :h8),
          coordinate_set(:e3, :f2, :g1),
          coordinate_set(:c3, :b2, :a1),
          coordinate_set(:c5, :b6, :a7)
        ]

        expect(bishop.raw_directional_moves(game)).to eq(expected)
      end
    end
  end
end
