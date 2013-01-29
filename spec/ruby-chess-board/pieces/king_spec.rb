require 'spec_helper'

module RubyChessBoard
  describe King do
    it_should_behave_like 'a chess piece'

    describe "raw directional moves" do
      let(:king)  { game.board.e1 }
      let(:game)  { Game.new(boards) }

      let(:boards) do
        board_1 = Board.new
        board_2 = Board.new(board_1)
        board_2.move_piece(:e1, :d3)

        [board_1, board_2]
      end

      it "includes all immediate spaces around it" do
        king # preload king
        game.last
        expected_moves = coordinates(:d4, :e4, :e3, :e2, :d2, :c2, :c3, :c4)
        expect(king.raw_directional_moves(game)).to eq(expected_moves)
      end
    end
  end
end
