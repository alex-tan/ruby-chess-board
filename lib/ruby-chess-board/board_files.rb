module RubyChessBoard
  # Encapsulates eight {BoardFile} objects.
  class BoardFiles
    include Enumerable
    
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
    
    # Returns a clone of itelf. Changing the clone's files or positions will
    # not affect the original object.
    # @return [BoardFiles]
    def clone
      Marshal::load(Marshal.dump(self))
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

    private

    def file_names
      @file_names ||= Board.file_names
    end
  end
end
