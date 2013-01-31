require 'spec_helper'

module RubyChessBoard
  describe CoordinateCollection do
    subject(:collection) { build(:coordinate_collection) }

    describe "initialize" do
      its(:sets) { should == [] }
      its(:coordinates) { should == [] }
    end

    describe "initialize with arguments" do
      let(:sets)        { [build(:coordinate_set)] }
      let(:coordinates) { [build(:coordinate)] }

      subject(:collection) do
        build :coordinate_collection, sets: sets, coordinates: coordinates
      end

      it "can set collections and sets" do
        expect(collection.sets).to eq(sets) 
        expect(collection.coordinates).to eq(coordinates)
      end
    end

    it "stores coordinate sets" do
      set = build(:coordinate_set)
      collection.sets = [set]
      expect(collection.sets).to eq([set])
    end

    it "stores individual coordinates" do
      coords = coordinate_array(:a1, :b4)
      collection.coordinates = coords
      expect(collection.coordinates).to eq(coords)
    end

    describe "#without_blocks" do
      let(:board) do
        board = build(:board)
        board.move_piece(:d1, :d4)
        board
      end

      let(:game)  { build(:game, boards: [board]) }
      let(:piece) { board.d4 }
      let(:original_sets) { [coordinate_set(:c4, :b4, :a4)] }
      let(:original_coordinates) { coordinate_array(:d5) }
      let(:collection) do
        collection = build :coordinate_collection,
          sets: original_sets,
          coordinates: original_coordinates 
      end

      let(:without_blocks) { collection.without_blocks(piece: piece, game: game) }

      describe "#sets" do
        context "when there are no blocks" do
          it "keeps all sets the same" do
            expect(without_blocks.sets).to eq(original_sets)
          end      
        end

        context "when there is a block by a piece of the same color" do
          it "removes pieces from that point on" do
            board.move_piece(:b2, :b4)

            expected = [coordinate_set(:c4)]

            expect(without_blocks.sets).to eq(expected)
          end 
        end

        context "when there is a block by a piece of a different color" do
          it "removes pieces after that point" do
            board.move_piece(:b7, :b4)
            expected = [coordinate_set(:c4, :b4)]

            expect(without_blocks.sets).to eq(expected)
          end
        end
      end

      describe "#coordinates" do
        context "when there are no blocks" do
          it "returns all the coordinates" do
            expect(without_blocks.coordinates).to eq(original_coordinates)
          end
        end

        context "when there are blocks by opponent pieces" do
          it "does not remove those coordinates" do
            board.move_piece(:d7, :d5) 
            expect(without_blocks.coordinates).to eq(original_coordinates) 
          end
        end

        context "when there are blocks by ally pieces" do
          it "removes those coordinates" do
            board.move_piece(:f2, :d5)
            expect(without_blocks.coordinates).to be_empty
          end
        end
      end
    end

    describe "equality testing" do
      context "when sets and coordinates are equal" do
        it "should be equal" do
          collection_2 = build(:coordinate_collection)
          expect(collection).to eq(collection_2)
        end 
      end

      context "when sets are not equal" do
        it "should not be equal" do
          collection_2 = build :coordinate_collection,
            sets: [build(:coordinate_set)]
          expect(collection).to_not eq(collection_2)
        end 
      end

      context "when coordinates are equal" do
        it "should not be equal" do
          collection_2 = build :coordinate_collection,
            coordinates: [build(:coordinate)] 

          expect(collection_2).to_not eq(collection)
        end
      end
    end

    describe "#compact" do
      let(:real_coordinate_set) { build(:coordinate_set) }
      let(:real_coordinate)     { build(:coordinate) }

      subject(:collection) do
        build :coordinate_collection,
          sets: [
            real_coordinate_set,
            build(:coordinate_set, coordinates: [])
        ],
          coordinates: [
            real_coordinate,
            build(:impossible_coordinate)
        ]
      end

      let(:compacted) { collection.compact }

      it "does not affect the original collection" do
        expect { compacted }.to_not change { collection }
      end
      it "returns a collection without empty sets" do
        expect(compacted.sets).to eq([real_coordinate_set])
      end

      it "returns a collection without impossible coordinates" do
        expect(compacted.coordinates).to eq([real_coordinate])
      end
    end
  end
end
