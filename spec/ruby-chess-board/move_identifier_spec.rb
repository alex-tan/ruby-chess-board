require 'spec_helper'

module RubyChessBoard
  shared_examples "move identification" do
    it "identifies destination" do
      expected_moves = [:e4, :a4, :d4, :h4, :b8, :h8]
      expect(moves.map(&:destination)).to eq(expected_moves)
    end

    it "identifies piece type" do
      expected_pieces = [King, Queen, Rook, Bishop, Knight, Pawn]
      expect(moves.map(&:piece_type)).to eq(expected_pieces)
    end
  end

  shared_examples 'normal move identification' do
    it_behaves_like "move identification"

    it "identifies move type as normal" do
      moves.each { |m| expect(m.move_type).to eq(:normal) }
    end
  end

  shared_examples "capture move identification" do
    it_behaves_like "move identification"  

    it "identifies move type as capture" do
      moves.each { |m| expect(m.move_type).to eq(:capture) }
    end
  end

  shared_examples "castle identification" do
    it "does not identify destination" do
      expect(identity.destination).to be_nil
    end

    it "does not identify file" do
      expect(identity.destination).to be_nil
    end

    it "does not identify rank" do
      expect(identity.rank).to be_nil
    end
  end

  describe MoveIdentifier do
    subject(:identifier) { MoveIdentifier.new }

    before do
      [:promotion_piece_type, :piece_type, :move_type, :square, :file, :rank].each do |ivar|
        identifier.instance_variable_set("@#{ivar}", "Placeholder")
      end
    end

    describe "[Piece Letter][Destination]" do
      let(:moves) do
        %w[Ke4 Qa4 Rd4 Bh4 Nb8 h8].map { |m| identifier.identify(m) }
      end

      it_behaves_like 'normal move identification'

      it "does not identify file" do
        moves.each { |m| expect(m.file).to eq(nil) }
      end

      it "does not identify rank" do
        moves.each { |m| expect(m.rank).to eq(nil) }
      end
    end

    describe "[Piece Letter][File][Destination]" do
      let(:moves) do
        %w[Kae4 Qea4 Rbd4 Bdh4 Nhb8 ch8].map { |m| identifier.identify(m) }
      end

      it_behaves_like 'normal move identification'

      it "identifies file" do
        expected_files = [:a, :e, :b, :d, :h, :c]
        expect(moves.map(&:file)).to eq(expected_files)
      end

      it "does not identify rank" do
        moves.each { |m| expect(m.rank).to eq(nil) }
      end
    end

    describe "[Piece Type][Rank][Destination]" do
      let(:moves) do
        %w[K2e4 Q5a4 R1d4 B8h4 N3b8 7h8].map { |m| identifier.identify(m) }
      end

      it_behaves_like 'normal move identification'

      it "does not identify file" do
        moves.each { |m| expect(m.file).to eq(nil) }
      end

      it "identifies rank" do
        expected_ranks = [2, 5, 1, 8, 3, 7]
        expect(moves.map(&:rank)).to eq(expected_ranks)
      end
    end

    describe "[Piece Type][File and Rank][Destination]" do
      let(:moves) do
        %w[Kb2e4 Qe5a4 Ra1d4 Bb8h4 Nb3b8 h7h8].map { |m| identifier.identify(m) }
      end

      it_behaves_like "normal move identification"

      it "identifies file" do
        expected_files = [:b, :e, :a, :b, :b, :h]
        expect(moves.map(&:file)).to eq(expected_files)
      end

      it "identifies rank" do
        expected_ranks = [2, 5, 1, 8, 3, 7]
      end
    end

    describe "[Piece Type][File]x[Destination]" do
      let(:moves) do
        %w[Kaxe4 Qexa4 Rbxd4 Bdxh4 Nhxb8 cxh8].map { |m| identifier.identify(m) }
      end

      it_behaves_like 'capture move identification'

      it "identifies file" do
        expected_files = [:a, :e, :b, :d, :h, :c]
        expect(moves.map(&:file)).to eq(expected_files)
      end

      it "does not identify rank" do
        moves.each { |m| expect(m.rank).to eq(nil) }
      end 
    end

    describe "[Piece Type][Rank]x[Destination]" do
      let(:moves) do
        %w[K2xe4 Q5xa4 R1xd4 B8xh4 N3xb8 7xh8].map { |m| identifier.identify(m) }
      end

      it_behaves_like "capture move identification"

      it "identifies rank" do
        expected_ranks = [2, 5, 1, 8, 3, 7] 
        expect(moves.map(&:rank)).to eq(expected_ranks)
      end

      it "does not identify file" do
        moves.each { |m| expect(m.file).to eq(nil) }
      end
    end

    describe "[Piece Type][File and Rank]x[Destination]" do
      let(:moves) do
        %w[Kb2xe4 Qe5xa4 Ra1xd4 Bb8xh4 Nb3xb8 h7xh8].map { |m| identifier.identify(m) }
      end

      it_behaves_like "capture move identification"

      it "identifies file" do
        expected_files = [:b, :e, :a, :b, :b, :h]
        expect(moves.map(&:file)).to eq(expected_files)
      end

      it "identifies rank" do
        expected_ranks = [2, 5, 1, 8, 3, 7]
      end
    end

    describe "O-O" do
      let(:identity) { identifier.identify('O-O') }

      it_behaves_like "castle identification"

      it "identifies move type as :kingside_castle" do
        expect(identity.move_type).to eq(:kingside_castle) 
      end 

      it "identifies piece type as King and Rook" do
        expect(identity.piece_type).to eq([King, Rook])
      end
    end

    describe "O-O-O" do
      let(:identity) { identifier.identify('O-O-O') }

      it "identifies move type as :queenside_castle" do
        expect(identity.move_type).to eq(:queenside_castle)
      end

      it "identifies piece type as King and Queen" do
        expect(identity.piece_type).to eq([King, Queen]) 
      end

      it_behaves_like "castle identification" 
    end

    describe "[Destination]=[Promotion Piece Type]" do
      let(:moves) do
        %w[a8=Q h1=R g8=N e1=B].map { |m| identifier.identify(m) }
      end
      
      it "identifies move type as promotion" do
        moves.each { |m| expect(m.move_type).to eq(:promotion) }
      end

      it "identifies piece type as Pawn" do
        moves.each { |m| expect(m.piece_type).to eq(Pawn) }
      end

      it "identifies promotion piece type" do
        expected_piece_types = [Queen, Rook, Knight, Bishop]
        expect(moves.map(&:promotion_piece_type)).to eq(expected_piece_types)
      end

      it "identifies destination" do
        expected_destinations = [:a8, :h1, :g8, :e1]
        expect(moves.map(&:destination)).to eq(expected_destinations)
      end
    end

    describe "Unidentifiable Moves" do
      it "raises an error" do
        expect { identifier.identify('blah') }.to raise_error
      end
    end
  end
end
