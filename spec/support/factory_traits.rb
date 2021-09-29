FactoryBot.define do
  trait :chess_piece do
    color { :white }

    initialize_with { new(color: color, starting_position: starting_position) }
  end
end
