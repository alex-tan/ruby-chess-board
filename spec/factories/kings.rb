FactoryBot.define do
  factory :king, class: RubyChessBoard::King do
    chess_piece
    starting_position { :e1 }
  end
end
