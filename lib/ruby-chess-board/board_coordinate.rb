module RubyChessBoard
  class BoardCoordinate
    include BoardReferences

    ImpossibleCoordinate = Class.new

    attr_reader :x, :y

    def initialize(*args)
      case args.size
      when 1
        set_x_and_y_from_square(args.first)
      when 2
        if args.first.kind_of?(Integer)
          @x = args.first 
          @y = args.last 
        else
          set_x_and_y_from_square("#{args.first}#{args.last}")
        end
      end
    end
    
    # Returns an array of adjacent file names to the coordinate.
    # @return [Array<Symbol>]
    def adjacent_files
      files = []
      files << file_names[x - 1] unless file == :a
      files << file_names[x + 1] unless file == :h 
      files
    end
    
    # Returns the coordinate in this format: '(x, y)'
    # @return [String]
    def to_s
      square_name.to_s
    end
    
    # Returns the board rank of a coordinate.
    # @return [Integer]
    def rank
      y + 1
    end

    # Returns the file name of the coordinate.
    # @return [Symbol]
    def file
      file_names[x]
    end

    # Is true if the coordinates' x's and y's are equal.
    # @param [BoardCoordinate] coordinate
    # @return [Boolean]
    def ==(coordinate)
      coordinate.kind_of?(BoardCoordinate) &&
        x == coordinate.x &&
        y == coordinate.y
    end

    # Given a relative change in x and y, returns a BoardCoordinate
    # if the new coordinate is in bounds, otherwise returns
    # an instance of ImpossibleCoordinate.
    # @return [BoardCoordinate, ImpossibleCoordinate]
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
    # @return [CoordinateSet]
    # @option options [Integer] :limit The maximum number of coordinates to return.
    def relative_coordinate_set(x_change, y_change, options = {})
      current_x = x + x_change
      current_y = y + y_change

      set = []

      until ! in_bounds?(current_x, current_y) || (options[:limit] && set.size >= options[:limit])
        set << BoardCoordinate.new(current_x, current_y)

        current_x += x_change
        current_y += y_change
      end

      CoordinateSet.new(set)
    end

    # Returns the coordinate's square name as a symbol.
    # @return [Symbol]
    def square_name
      "#{file}#{rank}".to_sym
    end

    private

    def set_x_and_y_from_square(square)
      square = square.to_s

      @x = file_names.index(square[0].to_sym)
      @y = rank_names.index(square[1].to_i)
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
