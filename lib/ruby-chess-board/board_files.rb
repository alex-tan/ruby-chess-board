module RubyChessBoard
  class BoardFiles
    attr_reader :files

    def initialize
      @files = Array.new(8) { BoardFile.new }
    end

    def clone 
      Marshal::load(Marshal.dump(self))
    end

    def find(file_name)
      file_name = file_name.to_sym
      file_index = Board.file_names.index(file_name)

      files[file_index]
    end
  end
end
