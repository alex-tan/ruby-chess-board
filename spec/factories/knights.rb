FactoryGirl.define do
  factory :knight, class: RubyChessBoard::Knight do
    chess_piece
    starting_position :b1
  end
end
