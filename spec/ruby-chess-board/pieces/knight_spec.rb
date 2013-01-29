require 'spec_helper'

module RubyChessBoard
  describe Knight do
    it_should_behave_like 'a chess piece'

    describe "raw directional moves" do
      let(:game) { Game.new(boards) }
      let(:boards) do
        board = Board.new
        board.move_piece(:b1, :d4)
        [board]
      end
      
      it "should include all possible L moves" do
        knight = game.board.d4
        expected_moves = coordinates(:e6, :f5, :f3, :e2, :c2, :b3, :b5, :c6)
        expect(knight.raw_directional_moves(game)).to eq(expected_moves)
      end
    end
  end
end
