module RubyChessBoard
  shared_examples_for 'a chess piece' do
    def class_to_factory_name(klass)
      klass.name.split("::").last.downcase
    end

    def piece_factory(options = {})
      factory_name = class_to_factory_name(described_class)
      build(factory_name, options)
    end

    def alternate_class
      piece_classes = [King, Queen, Bishop, Knight, Rook, Pawn]
      piece_classes.find { |c| c != described_class } 
    end

    def alternate_factory(options = {})
      factory_name = class_to_factory_name(alternate_class)
      build(factory_name, options)
    end

    subject(:piece) { piece_factory }

    describe "testing for equality" do
      context "when the subject shares the same class, color, and starting position" do
        let(:piece_2) { piece_factory }

        specify 'they should be equal' do
          expect(piece).to eq(piece_2)
        end
      end

      context "when the subject does not share color" do
        let(:piece_2) { piece_factory(color: :black) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2) 
        end
      end

      context "when the subject does not share class" do
        let(:piece_2) { alternate_factory(starting_position: piece.starting_position) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2)
        end
      end

      context "when the subject does not share starting position" do
        let(:piece_2) { piece_factory(starting_position: :h7) }

        specify 'they should not be equal' do
          expect(piece).to_not eq(piece_2)
        end
      end
    end

    describe "#directional_moves" do
      let(:game) { build(:game) }

      it "compacts and returns the raw directional moves"
    end

    describe "#possible_moves" do
      it "limits directional moves by removing self-check moves"
    end
      
    describe "#opponent?" do
      context "when the variable is not a piece" do
        it "is false" do
          square = build(:empty_square)
          expect(piece.opponent?(square)).to be false
        end
      end

      context "when the variable is a piece of the same color" do
        it "is false" do
          opponent = piece_factory(color: piece.color)
          expect(piece.opponent?(opponent)).to be false
        end
      end

      context "when the variable is a piece of a differnt color" do
        it "is true" do
          opponent = piece_factory(color: piece.opposite_color)
          expect(piece.opponent?(opponent)).to be true
        end
      end
    end

    describe "#ally?" do
      context "when the subject is not a piece" do
        it "should be nil" do
          coord = build(:impossible_coordinate)
          expect(piece.ally?(coord)).to be false 
        end
      end 

      context "when the subject is a different piece of the same color" do
        it "should be true" do
          ally = alternate_factory(color: piece.color)         
          expect(piece.ally?(ally)).to be true
        end
      end

      context "when the subject is a the same piece of the same color" do
        it "should be true" do
          ally = piece_factory(color: piece.color)
          expect(piece.ally?(ally)).to be true
        end
      end
      
      context "when the subject is the same piece of a different color" do
        it "should be false" do
          opponent = piece_factory(color: piece.opposite_color)
          expect(piece.ally?(opponent)).to be false
        end
      end
    end
  end
end
