require 'spec_helper'

module RubyChessBoard
  describe CoordinateSet do
    it "stores coordinates" do
      coordinates = coordinate_array(:e1, :a4, :b5)
      set = build :coordinate_set, coordinates: coordinates

      expect(set.coordinates).to eq(coordinates)
    end

    describe "#empty?" do
      context "when there are no coordinates" do
        it "returns true" do
          expect(build(:coordinate_set, :empty)).to be_empty
        end
      end

      context "when there are coordinates" do
        it "returns false" do
          set = build(:coordinate_set, coordinates: coordinate_array(:a1))
          expect(set).to_not be_empty
        end
      end
    end

    describe "#equality testing" do
      subject(:set) { build(:coordinate_set, coordinates: coordinate_array(:b4, :a4)) }

      context "when the coordinates are the same" do
        specify "they are equal" do
          set_2 = build(:coordinate_set, coordinates: coordinate_array(:b4, :a4))

          expect(set).to eq(set_2)
        end
      end

      context "when the coordinates are not the same or not ordered the same" do
        specify "they are not equal" do
          set_2 = build(:coordinate_set, coordinates: coordinate_array(:c4, :g4))

          expect(set).to_not eq(set_2)
        end
      end

      context "when compared to another class" do
        specify "it is not equal" do
          expect(set).to_not eq(build(:pawn))
        end
      end
    end

    describe "#without_blocks" do
      let(:coordinates) { coordinate_array(:c4, :b4, :a4) }
      let(:set)         { build(:coordinate_set, coordinates: coordinates) }

      let(:board)       { build(:board) }
      let(:queen)       { board.d4 }
      let(:game)        { build(:game, boards: [board]) }

      before { board.move_piece(:d1, :d4) }

      context "when there are no blocks" do
        it "removes no coordinates" do
          expect(set.without_blocks(piece: queen, game: game)).to eq(set)
        end
      end

      context "when there is a block in between by a piece of the same color" do
        before { board.move_piece(:b2, :b4) }

        it "blocks from that point on" do
          expected = build(:coordinate_set, coordinates: coordinate_array(:c4))
          expect(set.without_blocks(piece: queen, game: game)).to eq(expected)
        end
      end

      context "when there is a block by a piece of a different color" do
        before { board.move_piece(:b7, :b4) }

        it "blocks all coordinates after the block" do
          expected = build(:coordinate_set, coordinates: coordinate_array(:c4, :b4))
          expect(set.without_blocks(piece: queen, game: game)).to eq(expected)
        end
      end
    end
  end
end
