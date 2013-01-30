module RubyChessBoard
  shared_examples_for 'a chess piece' do
    def class_to_factory(klass)
      klass.name.split("::").last.downcase
    end

    def piece_factory(options = {})
      factory_name = class_to_factory(described_class)
      build(factory_name, options)
    end

    def alternate_class
      piece_classes = [King, Queen, Bishop, Knight, Rook, Pawn]
      piece_classes.find { |c| c != described_class } 
    end

    def alternate_factory(options = {})
      factory_name = class_to_factory(alternate_class)
      build(factory_name, options)
    end

    def alternate_color(piece)
      (Piece.colors - [piece.color]).first
    end

    subject(:piece) { piece_factory }

    describe "testing for equality" do
      context "when the pieces share the same class, color, and starting position" do
        let(:piece_2) { piece_factory }

        specify 'they should be equal' do
          expect(piece).to eq(piece_2)
        end
      end

      context "when the pieces do not share color" do
        let(:piece_2) { piece_factory(color: :black) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2) 
        end
      end

      context "when the pieces don't share class" do
        let(:piece_2) { alternate_factory(starting_position: piece.starting_position) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2)
        end
      end

      context "when the pieces don't share starting position" do
        let(:piece_2) { piece_factory(starting_position: :h7) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2)
        end
      end
    end

    describe "#directional_moves" do
      let(:game) { build(:game) }

      it "compacts and returns the raw directional moves" do
        piece.expects(:raw_directional_moves).with(game).returns(moves = stub)
        moves.expects(:compact).returns(result = stub)

        expect(piece.directional_moves(game)).to eq(result)
      end
    end
      
    describe "#opponent?" do
      context "when the variable is not a piece" do
        it "is false" do
          square = build(:empty_square)
          expect(piece.opponent?(square)).to be_false
        end
      end

      context "when the variable is a piece of the same color" do
        it "is false" do
          opponent = piece_factory(color: piece.color)
          expect(piece.opponent?(opponent)).to be_false
        end
      end

      context "when the variable is a piece of a differnt color" do
        it "is true" do
          opponent = piece_factory(color: alternate_color(piece))
          expect(piece.opponent?(opponent)).to be_true
        end
      end
    end

    describe "#ally?" do
      context "when the variable is not a piece" do
        it "should be nil" do
          coord = build(:impossible_coordinate)
          expect(piece.ally?(coord)).to be_false 
        end
      end 

      context "when the variable is a different piece of the same color" do
        it "should be true" do
          ally = alternate_factory(color: piece.color)         
          expect(piece.ally?(ally)).to be_true
        end
      end

      context "when the variable is a the same piece of the same color" do
        it "should be true" do
          ally = piece_factory(color: piece.color)
          expect(piece.ally?(ally)).to be_true
        end
      end
      
      context "when the variable is the same piece of a different color" do
        it "should be false" do
          opponent = piece_factory(color: alternate_color(piece))
          expect(piece.ally?(opponent)).to be_false
        end
      end
    end
  end
end
