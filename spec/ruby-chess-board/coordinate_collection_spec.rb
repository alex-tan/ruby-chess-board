require 'spec_helper'

module RubyChessBoard
  describe CoordinateCollection do
    subject(:collection) { CoordinateCollection.new }

    it "stores coordinate sets" do
      set = build(:coordinate_set)
      collection.sets = [set]
      expect(collection.sets).to eq([set])
    end

    it "stores individual coordinates" do
      coords = coordinates(:a1, :b4)
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
          collection_2.sets = [coordinates(:b4)]
          expect(collection).to_not eq(collection_2)
        end 
      end

      context "when coordinates are equal" do
        it "should not be equal" do
          collection_2 = CoordinateCollection.new
          collection_2.coordinates = coordinates(:a1)

          expect(collection_2).to_not eq(collection)
        end
      end
    end
  end
end
