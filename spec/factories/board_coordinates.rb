FactoryBot.define do
  factory :coordinate, class: RubyChessBoard::Coordinate do
    transient do
      square_name { :a1 }
      x { nil }
      y { nil }
      file { nil }
      rank { nil }
    end

    initialize_with do
      if x && y
        new(x, y)
      elsif file && rank
        new(file, rank)
      else
        new(square_name)
      end
    end
  end
end
