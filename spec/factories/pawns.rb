FactoryBot.define do
  factory :pawn, class: RubyChessBoard::Pawn do
    chess_piece
    starting_position { :a2 }
  end
end
