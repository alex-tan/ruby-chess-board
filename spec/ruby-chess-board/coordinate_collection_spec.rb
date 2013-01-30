require 'spec_helper'

module RubyChessBoard
  describe CoordinateCollection do
    subject(:collection) { CoordinateCollection.new }
    
    describe "initialize" do
      its(:sets) { should == [] }
      its(:coordinates) { should == [] }
    end

    describe "initialize with arguments" do
      let(:sets) { [build(:coordinate_set)] }
      let(:coordinates) { [build(:board_coordinate)] }
      subject(:collection) do
        CoordinateCollection.new(sets: sets, coordinates: coordinates)
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

    describe "equality testing" do
      context "when sets and coordinates are equal" do
        it "should be equal" do
          collection_2 = CoordinateCollection.new
          expect(collection).to eq(collection_2)
        end 
      end

      context "when sets are not equal" do
        it "should not be equal" do
          collection_2 = CoordinateCollection.new
          collection_2.sets = [build(:coordinate_set)]
          expect(collection).to_not eq(collection_2)
        end 
      end

      context "when coordinates are equal" do
        it "should not be equal" do
          collection_2 = CoordinateCollection.new
          collection_2.coordinates = [build(:board_coordinate)] 

          expect(collection_2).to_not eq(collection)
        end
      end
    end
  end
end
