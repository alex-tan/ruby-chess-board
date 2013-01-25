require 'spec_helper'

module RubyChessBoard
  describe BoardCoordinate do
    subject(:coordinate) { BoardCoordinate.new(0, 0) }

    describe "#rank" do
      it "returns the y value + 1" do
        expect(coordinate.rank).to eq(1)
      end
    end

    describe "#square_name" do
      it "should return the coordinate's square name" do
        expect(coordinate.square_name).to eq(:a1)
      end
    end

    describe "equality testing" do
      context "when x's and y's are the same" do
        let(:coordinate_2) { BoardCoordinate.new(0, 0) }

        it { should eq(coordinate_2) }
      end

      context "when x's are not the same" do
        let(:coordinate_2) { BoardCoordinate.new(1, 0) }

        it { should_not eq(coordinate_2) }
      end

      context "when y's are not the same" do
        let(:coordinate_2) { BoardCoordinate.new(0, 1) }

        it { should_not eq(coordinate_2) }
      end
    end

    describe "initialize" do
      it "initializes with a square name" do
        coord = BoardCoordinate.new(:a1)

        expect(coord.x).to eq(0)
        expect(coord.y).to eq(0)
        expect(coord.square_name).to eq(:a1)
      end

      it "initializes with an x and a y" do
        expect(coordinate.x).to eq(0)
        expect(coordinate.y).to eq(0)
        expect(coordinate.square_name).to eq(:a1)
      end
    end

    describe "relative_coordinate" do
      context "when the x and y are in bounds" do
        it "returns the relative coordinate" do
          expected = BoardCoordinate.new(7, 7)
          expect(coordinate.relative_coordinate(7, 7)).to eq(expected)
        end
      end

      context "when the x is out of bounds" do
        it "returns an ImpossibleCoordinate" do
          expect(coordinate.relative_coordinate(8, 7)).to be_kind_of(BoardCoordinate::ImpossibleCoordinate)
        end
      end

      context "when the y is out of bounds" do
        it "returns an ImpossibleCoordinate" do
          expect(coordinate.relative_coordinate(7, 8)).to be_kind_of(BoardCoordinate::ImpossibleCoordinate)
        end
      end
    end

    describe "relative_coordinate_set" do
      context "when x and y are in bounds" do
        it "returns as many coordinates as it can" do
          expected = (1..7).map { |n| BoardCoordinate.new(n, n) }

          expect(coordinate.relative_coordinate_set(1, 1)).to eq(expected)
        end
      end

      context "when x is out of bounds" do
        it "returns an empty array" do
          expect(coordinate.relative_coordinate_set(-1, 1)).to eq([])
        end
      end

      context "when y is out of bounds" do
        it "returns an empty array" do
          expect(coordinate.relative_coordinate_set(1, -1)).to eq([])
        end
      end
    end
  end
end
