# typed: false
require 'spec_helper'

module RubyChessBoard
  describe Rook do
    it_should_behave_like 'a chess piece' 

    describe "raw directional moves" do
      let(:game) { build(:game, boards: boards) }
      let(:boards) do
        board = build(:board)
        board.move_piece(:a1, :d4)
        [board]
      end

      it "returns 2 horizontal sets and 2 vertical sets" do
        board = game.board
        rook  = board.d4

        expected = build :coordinate_collection, sets: [
          coordinate_set(:d5, :d6, :d7, :d8),
          coordinate_set(:e4, :f4, :g4, :h4),
          coordinate_set(:d3, :d2, :d1),
          coordinate_set(:c4, :b4, :a4)
        ]

        expect(rook.raw_directional_moves(game)).to eq(expected)
      end
    end
  end
end
