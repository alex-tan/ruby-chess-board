# typed: false
FactoryBot.define do
  factory :rook, class: RubyChessBoard::Rook do
    chess_piece
    starting_position { :a1 }
  end
end
