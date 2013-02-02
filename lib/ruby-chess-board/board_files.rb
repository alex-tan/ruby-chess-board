module RubyChessBoard
  # Encapsulates eight {BoardFile} objects.
  class BoardFiles
    include BoardReferences, Enumerable, MarshalClone
    
    # @private
    attr_reader :files

    def initialize
      @files = Array.new(8) { BoardFile.new }
    end
    
    # Yields each file, starting with a, going through h.
    # @yield [BoardFile] file
    def each
      files.each { |file| yield file }
    end

    # Yields each file and its file as Symbol.
    # @yield [BoardFile] file
    # @yield [Symbol] file name
    def each_with_file_name
      files.each_with_index { |file, index| yield file, file_names[index] }
    end
    
    # Takes a file name and returns the corresponding {BoardFile}.
    # @param [Symbol, String] file_name
    def [](file_name)
      file_name = file_name.to_sym
      file_index = file_names.index(file_name)

      files[file_index]
    end
  
    # Given a file, returns its array index.
    # @param [BoardFile] file
    # @return [Integer] array index of a file
    def index(file)
      files.index(file)
    end
    
    # Returns all pieces of a given color.
    # @param [Symbol] color :white or :black
    def pieces(color)
      pieces = []
      
      each do |file|
        file.each_rank do |piece|
          pieces << piece if piece.kind_of?(Piece) && piece.color == color 
        end
      end

      pieces
    end
  end
end
