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

    describe "directional_moves" do
      let(:raw_moves) do
        [
          coordinate(:a1),
          BoardCoordinate::ImpossibleCoordinate.new,
          coordinate(:g5),
          [],
          coordinate(:f6)
        ]
      end

      it "returns raw directional moves with empty arrays and impossible coordinates filtered out" do
        game = build(:game)
        piece.expects(:raw_directional_moves).with(game).returns(raw_moves)

        expected_moves = coordinates(:a1, :g5, :f6)

        expect(piece.directional_moves(game)).to eq(expected_moves)
      end
    end
  end
end
