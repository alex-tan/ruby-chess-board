FactoryGirl.define do
  factory :coordinate_collection, class: RubyChessBoard::CoordinateCollection do
    sets { [] }
    coordinates { [] }
    initialize_with { new(sets: sets, coordinates: coordinates) }
  end
end
