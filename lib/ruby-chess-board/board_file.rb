module RubyChessBoard
  class BoardFile
    attr_reader :ranks

    def initialize
      @ranks = Array.new(8)
    end

    def rank(rank_number)
      rank_index = rank_index(rank_number)
      ranks[rank_index]
    end

    def set_rank(rank_number, value)
      rank_index = rank_index(rank_number) 
      @ranks[rank_index] = value
    end

    private

    def rank_index(rank_number)
      rank_number.to_i - 1
    end
  end
end
