require 'spec_helper'
module RubyChessBoard
  describe Queen do
    it_should_behave_like 'a chess piece' 
    
    describe "raw directional moves" do
      let(:game) { Game.new(boards) }

      let(:boards) do
        board_1 = Board.new
        board_2 = Board.new(board_1)
        board_2.move_piece(:d1, :d4)
        [board_1, board_2]
      end

      it "includes straight lines in all directions" do
        game.last
        queen = game.board.d4

        expected = build :coordinate_collection, sets: [
          coordinate_set(:d5, :d6, :d7, :d8),
          coordinate_set(:e5, :f6, :g7, :h8),
          coordinate_set(:e4, :f4, :g4, :h4),
          coordinate_set(:e3, :f2, :g1),
          coordinate_set(:d3, :d2, :d1),
          coordinate_set(:c3, :b2, :a1),
          coordinate_set(:c4, :b4, :a4),
          coordinate_set(:c5, :b6, :a7)
        ]

        expect(queen.raw_directional_moves(game)).to eq(expected)
      end
    end    
  end
end
