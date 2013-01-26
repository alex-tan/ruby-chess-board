require 'spec_helper'

module RubyChessBoard
  describe Game do
    let(:boards) { Array.new(2) { Board.new } } 

    subject(:game) { Game.new(boards) }

    describe "initialize" do
      it "should be at move 0" do
        expect(game.move).to eq(0)
      end

      specify "its board should be the first board" do
        expect(game.board).to eq(boards.first)
      end
    end

    describe "#moves" do
      it "should return the number of boards - 1" do
        expect(game.moves).to eq(1)
      end
    end

    describe "#board" do
      it "should return the board based on move number" do
        expect(game.board).to eq(boards.first)
        game.forward
        expect(game.board).to eq(boards.last)
      end
    end

    describe "#forward" do
      context "when there are more boards to move forward to" do
        it "ups the move by 1" do
          expect { game.forward }.to change { game.move }.by(1)
        end
      end

      context "when there are not more boards to move forward to" do
        it "raises an EndOfGame exception" do
          game.forward
          expect { game.forward }.to raise_error(Game::EndOfGame)
        end

        it "does not change the move" do
          begin
            2.times { game.forward }
          rescue Game::EndOfGame
          end

          expect(game.move).to eq(1) 
        end
      end
    end

    describe "#back" do
      context "when there are boards to move back to" do
        it "decreases the move by 1" do
          game.forward
          expect { game.back }.to change { game.move }.by(-1)
        end
      end

      context "when there is no board to move back to" do
        it "raises BeginningOfGame exception" do
          expect { game.back }.to raise_error(Game::BeginningOfGame)
        end

        it "does not change the move" do
          begin
            game.back
          rescue Game::BeginningOfGame
          end
          
          expect(game.move).to eq(0)
        end
      end
    end
  end
end
