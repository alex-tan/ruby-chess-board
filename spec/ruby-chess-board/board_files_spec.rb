require 'spec_helper'

module RubyChessBoard
  describe BoardFiles do
    subject(:files) { BoardFiles.new }

    it "is made up of eight board files" do
      retrieved = []

      files.each { |file| retrieved << file }

      expect(retrieved.size).to eq(8)
      
      retrieved.each do |file|
        expect(file).to be_kind_of(BoardFile)
      end
    end
    
    describe "#each" do
      it "yields each file" do
        result = []

        files.each { |file| result << file }

        result.each { |r| expect(r).to be_kind_of(BoardFile) }
      end
    end

    describe "#each_with_file_name" do
      it "yields each file with its file name" do
        file_arr = []
        names = []
        
        files.each_with_file_name do |file, name|
          file_arr << file
          names << name
        end

        file_arr.each { |file| expect(file).to be_kind_of(BoardFile) }
        expect(names).to eq(('a'..'h').map(&:to_sym))
      end
    end

    describe "#clone" do
      it "returns a deep clone of itself" do
        new_files = files.clone
        a = files[:a].at_rank(1)
        new_files[:a].set_rank(1, build(:pawn))
        b = files[:a].at_rank(1)
        expect(a).to eq(b)
      end
    end

    describe "#index" do
      it "return the array index of a file" do
        file = files.files[1]
        expect(files.index(file)).to eq(1)
      end
    end
  end
end
