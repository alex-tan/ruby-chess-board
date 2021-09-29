# typed: false
RSpec::Matchers.define :be_empty_square do
  match do |object|
    object.kind_of? RubyChessBoard::BoardFile::EmptySquare
  end
end
