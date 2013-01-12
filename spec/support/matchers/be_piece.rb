RSpec::Matchers.define :be_piece do |piece_class|
  chain(:with_color)             { |color| @color = color }
  chain(:with_starting_position) { |sp| @starting_position = sp }
  
  match do |piece|
    conditions = []
    @piece = piece

    conditions << piece.class == piece_class
    
    if @color
      conditions << (piece && piece.color == @color)
    end

    if @starting_position
      conditions << (piece && piece.starting_position == @starting_position.to_sym)
    end

    conditions.all?
  end

  failure_message_for_should do
    message = "expected that #{@piece.inspect} would be a #{@color} #{piece_class}"
    message << " with starting position #{@starting_position}" if @starting_position

    message
  end
end
