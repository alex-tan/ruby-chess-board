FactoryGirl.define do
  factory :board_coordinate, class: RubyChessBoard::BoardCoordinate do
    square_name :a1

    initialize_with { new(square_name) }
  end
end
