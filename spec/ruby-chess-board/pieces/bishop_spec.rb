require 'spec_helper'

module RubyChessBoard
  describe Bishop do
    it_should_behave_like 'a chess piece' 

    describe "raw directional moves" do
      let(:game) { Game.new(boards) }
      let(:boards) do
        board = Board.new
        board.move_piece(:c1, :d4)

        [board]
      end

      it "includes all diagonal positions on the board" do
        bishop = game.board.d4

        expected_moves = [
          coordinates(:e5, :f6, :g7, :h8),
          coordinates(:e3, :f2, :g1),
          coordinates(:c3, :b2, :a1),
          coordinates(:c5, :b6, :a7)
        ]

        expect(bishop.raw_directional_moves(game)).to eq(expected_moves)
      end
    end
  end
end
