module RubyChessBoard
  module BoardReferences
    private

    def file_names
      @file_names ||= Board.file_names
    end

    def rank_names
      @rank_names ||= Board.rank_names
    end
  end
end
