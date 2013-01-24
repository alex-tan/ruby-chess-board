module RubyChessBoard
  class BoardCoordinate
    ImpossibleCoordinate = Class.new

    attr_reader :x, :y

    def initialize(*args)
      case args.size
      when 1
        set_x_and_y_from_square(args.first)
      when 2
        @x = args.first 
        @y = args.last 
      end
    end

    # Returns true if the coordinates' x's and y's are equal.
    def ==(coordinate)
      x == coordinate.x && y == coordinate.y
    end

    # Given a relative change in x and y, returns a BoardCoordinate
    # if the new coordinate is in bounds. Otherwise returns
    # an instance of ImpossibleCoordinate.
    def relative_coordinate(x_change, y_change)
      new_x = x + x_change
      new_y = y + y_change

      if in_bounds?(new_x, new_y)
        BoardCoordinate.new(new_x, new_y)
      else
        ImpossibleCoordinate.new
      end
    end

    # Given a relative change in x and y, returns as many coordinates as
    # are on that board in that direction.
    # @return [Array]
    def relative_coordinate_set(x_change, y_change)
      current_x = x + x_change
      current_y = y + y_change

      set = []

      until ! in_bounds?(current_x, current_y)
        set << [current_x, current_y] 

        current_x += x_change
        current_y += y_change
      end

      set
    end

    def square
      "#{Board.file_names[x]}#{Board.rank_names[y]}".to_sym
    end

    private

    def set_x_and_y_from_square(square)
      square = square.to_s

      @x = Board.file_names.index(square[0].to_sym)
      @y = Board.rank_names.index(square[1].to_i)
    end

    def in_bounds?(x, y)
      possible_coordinates.cover?(x) &&
      possible_coordinates.cover?(y)
    end

    def possible_coordinates
      0..7
    end
  end
end
