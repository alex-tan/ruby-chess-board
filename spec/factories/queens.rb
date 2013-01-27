FactoryGirl.define do
  factory :queen, class: RubyChessBoard::Queen do
    chess_piece

    starting_position :d1
  end
end
