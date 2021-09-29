FactoryBot.define do
  factory :board, class: RubyChessBoard::Board do
    origin_board { nil }

    initialize_with do
      if origin_board
        new(origin_board)
      else
        new
      end
    end
  end
end
