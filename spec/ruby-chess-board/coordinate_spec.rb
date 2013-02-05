require 'spec_helper'

module RubyChessBoard
  describe Coordinate do
    subject(:coordinate) { build(:coordinate, square_name: :a1)}

    describe "#rank" do
      it "returns the rank of the coordinate" do
        expect(coordinate.rank).to eq(1)
      end
    end

    describe "#square_name" do
      it "returns the coordinate's square name" do
        expect(coordinate.square_name).to eq(:a1)
      end
    end

    describe "equality testing" do
      context "when the subject's x's and y's are the same" do
        let(:coordinate_2) { build(:coordinate, x: 0, y: 0) }
        
        it('is equal') { should eq(coordinate_2) }
      end

      context "when the subject's x is not the same" do
        let(:coordinate_2) { build(:coordinate, x: 1, y: 0) }

        it('is not equal') { should_not eq(coordinate_2) }
      end

      context "when the subject's y is not the same" do
        let(:coordinate_2) { build(:coordinate, x: 0, y: 1) }

        it('is not equal') { should_not eq(coordinate_2) }
      end

      context "when the subject is of a different class" do
        let(:coordinate_2) { build(:impossible_coordinate) }

        it('is not equal') { should_not eq(coordinate_2) }
      end
    end

    describe "initialize" do
      describe "initialization with a square name" do
        context "when a1" do
          subject(:coordinate) { build(:coordinate, square_name: :a1) } 

          it_behaves_like 'an a1 coordinate'
        end 

        context "when h8" do
          subject(:coordinate) { build(:coordinate, square_name: :h8) } 

          it_behaves_like 'an h8 coordinate'
        end 

        context "when g6" do
          subject(:coordinate) { build(:coordinate, square_name: :g6) } 

          it_behaves_like "a g6 coordinate"
        end
      end

      describe "initialization with an x and y" do
        context "when (0, 0)" do
          subject(:coordinate) { build(:coordinate, x: 0, y: 0) }

          it_behaves_like 'an a1 coordinate'
        end

        context "when (7, 7)" do
          subject(:coordinate) { build(:coordinate, x: 7, y: 7) }

          it_behaves_like 'an h8 coordinate'
        end

        context "when (6, 5)" do
          subject(:coordinate) { build(:coordinate, x: 6, y: 5) }

          it_behaves_like "a g6 coordinate"
        end
      end
      
      describe "initialization with a file and a rank" do
        context "when a, 1" do
          subject(:coordinate) { build(:coordinate, file: :a, rank: 1) }

          it_behaves_like "an a1 coordinate"
        end

        context "when h, 8" do
          subject(:coordinate) { build(:coordinate, file: :h, rank: 8) }

          it_behaves_like "an h8 coordinate"
        end

        context "when g, 6" do
          subject(:coordinate) { build(:coordinate, file: :g, rank: 6) }

          it_behaves_like "a g6 coordinate"
        end
      end
    end

    describe "#adjacent_files" do
      context "when the file is a" do
        it "returns :b in an array" do
          expect(coordinate.adjacent_files).to eq([:b])
        end
      end

      context "when the file is h" do
        subject(:coordinate) { build(:coordinate, square_name: :h6) }

        it "returns :g in an array" do
          expect(coordinate.adjacent_files).to eq([:g])
        end
      end

      context "when the file is in between a and h" do
        subject(:coordinate) { build(:coordinate, square_name: :e7) }

        it "returns its adjacent files" do
          expect(coordinate.adjacent_files).to eq([:d, :f])
        end
      end
    end

    describe "#relative_coordinate" do
      context "when the x and y are in bounds" do
        it "returns the relative coordinate" do
          expected = Coordinate.new(7, 7)
          expect(coordinate.relative_coordinate(7, 7)).to eq(expected)
        end
      end

      context "when the x is out of bounds" do
        it "returns an impossible coordinate" do
          expect(coordinate.relative_coordinate(8, 7)).to be_impossible_coordinate
        end
      end

      context "when the y is out of bounds" do
        it "returns an impossible coordinate" do
          expect(coordinate.relative_coordinate(7, 8)).to be_impossible_coordinate
        end
      end
    end

    describe "#relative_coordinate_set" do
      context "when x and y are in bounds" do
        it "returns as many coordinates as it can as a coordinate set" do
          expected = build :coordinate_set,
            coordinates: (1..7).map { |n| build(:coordinate, x: n, y: n) }

          expect(coordinate.relative_coordinate_set(1, 1)).to eq(expected)
        end
      end

      context "when x is out of bounds" do
        it "returns an empty coordinate set" do
          expected = build(:coordinate_set, :empty)
          expect(coordinate.relative_coordinate_set(-1, 1)).to eq(expected)
        end
      end

      context "when y is out of bounds" do
        it "returns an empty coordinate set" do
          expected = build(:coordinate_set, :empty)
          expect(coordinate.relative_coordinate_set(1, -1)).to eq(expected)
        end
      end
    end
  end
end
