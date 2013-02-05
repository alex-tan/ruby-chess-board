require 'spec_helper'

module RubyChessBoard
  describe CoordinateCollection do
    subject(:collection) { build(:coordinate_collection) }

    describe "initialize" do
      context "without arguments" do
        its(:sets)        { should == [] }
        its(:coordinates) { should == [] }
      end

      context "without arguments" do
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

    describe "#without_self_checks" do
      let(:board) do
        board = build(:board)
        board.move_piece(:d1, :d5)
        board.move_piece(:e1, :d4)
        board.move_piece(:d7, :d3)
        board
      end

      let(:game) { build(:game, boards: [board]) }

      let(:collection) do
        build :coordinate_collection,
          sets: original_sets,
          coordinates: original_coordinates 
      end

      let(:without_self_checks) do
        collection.without_self_checks(piece: piece, game: game)
      end

      describe "sets" do
        let(:piece)                { board.d5 }
        let(:original_coordinates) { [] }
        let(:original_sets) do
          [
            coordinate_set(:d6, :d7, :d8),
            coordinate_set(:e5, :f5, :g5, :h5)
          ]
        end
        
        it "removes set moves that would put the piece in check" do
          expected = [original_sets.first]
          expect(without_self_checks.sets).to eq(expected) 
        end
      end

      describe "coordinates" do
        it "removes coordinates that would put the piece in check" do
          pending
        end
      end
    end

    describe "#without_blocks" do
      let(:board) do
        board = build(:board)
        board.move_piece(:d1, :d4)
        board
      end

      let(:game)                 { build(:game, boards: [board]) }
      let(:piece)                { board.d4 }
      let(:original_sets)        { [coordinate_set(:c4, :b4, :a4)] }
      let(:original_coordinates) { coordinate_array(:d5) }
      let(:collection) do
        build :coordinate_collection,
          sets: original_sets,
          coordinates: original_coordinates 
      end

      let(:without_blocks) { collection.without_blocks(piece: piece, game: game) }

      describe "sets" do
        context "when there are no blocks" do
          it "keeps all sets the same" do
            expect(without_blocks.sets).to eq(original_sets)
          end      
        end

        context "when there is a block by a piece of the same color" do
          it "removes pieces from that point on in the set" do
            board.move_piece(:b2, :b4)

            expected = [coordinate_set(:c4)]

            expect(without_blocks.sets).to eq(expected)
          end 
        end

        context "when there is a block by a piece of a different color" do
          it "removes pieces after that point in the set" do
            board.move_piece(:b7, :b4)
            expected = [coordinate_set(:c4, :b4)]

            expect(without_blocks.sets).to eq(expected)
          end
        end
      end

      describe "coordinates" do
        context "when there are no blocks" do
          it "removes no coordinates" do
            expect(without_blocks.coordinates).to eq(original_coordinates)
          end
        end

        context "when there are blocks by opponent pieces" do
          it "removes no coordinates" do
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
        it "equals the subject" do
          collection_2 = build(:coordinate_collection)
          expect(collection).to eq(collection_2)
        end 
      end

      context "when sets are not equal" do
        it "does not equal the subject" do
          collection_2 = build :coordinate_collection,
            sets: [build(:coordinate_set)]
          expect(collection).to_not eq(collection_2)
        end 
      end

      context "when coordinates are not equal" do
        it "does not equal the subject" do
          collection_2 = build :coordinate_collection,
            coordinates: [build(:coordinate)] 

          expect(collection_2).to_not eq(collection)
        end
      end
    end

    describe "#without_empty_sets" do
      let(:real_coordinate_set) { build(:coordinate_set) }
      subject(:collection) do
        build :coordinate_collection,
          sets: [
            real_coordinate_set,
            build(:coordinate_set, coordinates: [])
        ]
      end

      let(:without_empty_sets) { collection.without_empty_sets }

      it "returns a collection without empty sets" do
        expect(without_empty_sets.sets).to eq([real_coordinate_set])
      end
    end

    describe "#without_impossible_coordinates" do
      let(:real_coordinate) { build(:coordinate) }

      subject(:collection) do
        build :coordinate_collection,
          coordinates: [
            real_coordinate,
            build(:impossible_coordinate)
        ]
      end

      let(:new_collection) { collection.without_impossible_coordinates }
      
      it "returns a collection without impossible coordinates" do
        expect(new_collection.coordinates).to eq([real_coordinate])
      end
    end

    describe "#include?" do
      let(:coordinate)  { build(:coordinate) }
      let(:coordinates) { [] }
      let(:sets)        { [] }
      
      let(:collection) do
        build :coordinate_collection,
          coordinates: coordinates,
          sets: sets
      end

      context "when a set includes the coordinate" do
        let(:sets) do
          [build(:coordinate_set, coordinates: [coordinate])]
        end

        it "is true" do
          expect(collection.include?(coordinate)).to be_true
        end
      end

      context "when coordinates include the coordinate" do
        let(:coordinates) { [ coordinate ] } 

        it "is true" do
          expect(collection.include?(coordinate)).to be_true
        end
      end

      context "when neither sets nor coordinates include the coordinate" do
        it "is false" do
          expect(collection.include?(coordinate)).to be_false
        end
      end
    end
  end
end
