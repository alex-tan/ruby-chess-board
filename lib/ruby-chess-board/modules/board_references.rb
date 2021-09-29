# typed: true
module RubyChessBoard
  # Contains references to {Board} attributes {Board#file_names} and
  # {Board#rank_names}
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
