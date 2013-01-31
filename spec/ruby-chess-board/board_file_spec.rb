require 'spec_helper'

module RubyChessBoard
  describe BoardFile do
    subject(:file) { build(:board_file) }

    it "is made up of 8 ranks" do
      expect(file.ranks.size).to eq(8)
    end

    describe "#each" do
      it "yields each of the ranks" do
        expected = (1..8).to_a

        expected.each do |number|
          file.set_rank(number, number)
        end

        result = []

        file.each { |rank| result << rank }

        expect(result).to eq(expected)
      end
    end

    describe "#has_piece?" do
      let(:piece) { build(:pawn) }

      context "when one of its ranks contains a piece" do
        it 'is true' do
          file.set_rank(1, piece)
          expect(file).to have_piece(piece)
        end
      end

      context "when none of its ranks contain a piece" do
        it 'is false' do
          expect(file).to_not have_piece(piece)
        end
      end
    end

    describe "#at_rank" do
      context "when there is something there" do
        it "returns what is at the rank number" do
          piece = build(:pawn)

          file.set_rank(4, piece)

          expect(file.at_rank(4)).to eq(piece)
        end
      end

      context "when there is nothing there" do
        it "returns an instance of EmptySquare" do
          expect(file.at_rank(4)).to be_empty_square 
        end
      end
    end

    describe "#set_rank" do
      it "sets a rank to the value provided" do
        piece = build(:pawn)
        expect { 
          file.set_rank(5, piece)
        }.to change { file.at_rank(5) }.to(piece)
      end
    end
  end
end
