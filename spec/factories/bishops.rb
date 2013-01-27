FactoryGirl.define do
  factory :bishop, class: RubyChessBoard::Bishop do
    chess_piece

    starting_position :c1
  end
end
