FactoryGirl.define do
  factory :coordinate_set, class: RubyChessBoard::CoordinateSet do
    coordinates do
      (1..3).map { |n| RubyChessBoard::BoardCoordinate.new(:a, n) }
    end

    initialize_with { new(coordinates) }

    trait :empty do
      coordinates []
    end
  end
end
