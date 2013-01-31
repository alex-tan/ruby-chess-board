module RubyChessBoard
  RSpec::Matchers.define :be_impossible_coordinate do
    match do |object|
      object.kind_of?(BoardCoordinate::ImpossibleCoordinate)
    end
  end
end
