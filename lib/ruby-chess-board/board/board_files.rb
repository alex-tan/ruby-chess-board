module RubyChessBoard
  class Board
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
        file_index = FILE_NAMES.index(file_name)

        files[file_index]
      end
    end
  end
end
