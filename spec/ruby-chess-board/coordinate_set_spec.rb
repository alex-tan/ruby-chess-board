require 'spec_helper'

module RubyChessBoard
  describe CoordinateSet do
    it "stores coordinates" do
      coordinates = coordinate_array(:e1, :a4, :b5)
      set = CoordinateSet.new(coordinates)
      expect(set.coordinates).to eq(coordinates)
    end

    describe "#empty?" do
      context "when there are no coordinates" do
        it "returns true" do
          expect(CoordinateSet.new([])).to be_empty
        end
      end

      context "when there are coordinates" do
        it "returns false" do
          expect(CoordinateSet.new(coordinate_array(:a1))).to_not be_empty
        end
      end
    end

    describe "#equality testing" do
      context "when the coordinates are the same" do
        specify "they are equal" do
          set_1 = CoordinateSet.new(coordinate_array(:b4, :a4))
          set_2 = CoordinateSet.new(coordinate_array(:b4, :a4))

          expect(set_1).to eq(set_2)
        end
      end

      context "when the coordinates are not the same or not ordered the same" do
        specify "they are not equal" do
          set_1 = CoordinateSet.new(coordinate_array(:g4, :c4))
          set_2 = CoordinateSet.new(coordinate_array(:c4, :g4))

          expect(set_1).to_not eq(set_2)
        end
      end

      context "when compared to another class" do
        specify "it is not equal" do
          expect(Coordinate.new(:a1)).to_not eq(CoordinateSet.new([:a1]))
        end
      end
    end

    describe "#without_blocks" do
      let(:coords) { coordinate_array(:c4, :b4, :a4) }
      let(:game) { Game.new([board]) }
      let(:queen) { board.d4 }
      let(:set) { CoordinateSet.new(coords) }

      context "when there are no blocks" do
        let(:board) do
          board = Board.new
          board.move_piece(:d1, :d4)
          board
        end

        it "removes no coordinates" do
          expect(set.without_blocks(piece: queen, game: game)).to eq(set)
        end
      end

      context "when there is a block from the beginning" do
        let(:board) do
          board = Board.new
          board.move_piece(:c2, :c4)
          board.move_piece(:d1, :d4)
          board
        end

        it "returns an empty coordinate set" do
          expect(set.without_blocks(piece: queen, game: game)).to eq(CoordinateSet.new([]))
        end
      end

      context "when there is a block in between by a piece of the same color" do
        let(:board) do
          board = Board.new
          board.move_piece(:b2, :b4)
          board.move_piece(:d1, :d4)
          board
        end

        it "blocks from that point on" do
          expected = CoordinateSet.new([coordinate(:c4)])
          expect(set.without_blocks(piece: queen, game: game)).to eq(expected)
        end
      end

      context "when there is a block by a piece of a different color" do
        let(:board) do
          board = Board.new
          board.move_piece(:b7, :b4)
          board.move_piece(:d1, :d4)
          board
        end

        it "blocks all coordinates after the block" do
          expected = CoordinateSet.new(coordinate_array(:c4, :b4))
          expect(set.without_blocks(piece: queen, game: game)).to eq(expected)
        end
      end
    end
  end
end
