FactoryGirl.define do
  factory :game, class: RubyChessBoard::Game do
    boards { Array.new(2) { RubyChessBoard::Board.new } }

    initialize_with { new(boards) }
  end
end
