# typed: false
# encoding: UTF-8

require 'spec_helper'

module RubyChessBoard
  describe BoardPrinter do
    subject(:printer) { BoardPrinter.new(build(:board)) }
     
    it "can represent pieces as icons" do
      expect(printer.icon(build(:king))).to eq('♔')
      expect(printer.icon(build(:queen))).to eq('♕')
      expect(printer.icon(build(:rook))).to eq('♖')
      expect(printer.icon(build(:bishop))).to eq('♗')
      expect(printer.icon(build(:knight))).to eq('♘')
      expect(printer.icon(build(:pawn))).to eq('♙')
      expect(printer.icon(build(:empty_square))).to eq('  ')
    end
  end
end
