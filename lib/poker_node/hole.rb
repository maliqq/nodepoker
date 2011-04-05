module PokerNode
  class Hole
    def initialize(river, hole)
      @river = river
      @hole = hole
    end

    def hand
      Hand.new(@river + @hole)
    end

    private

      def combine(&block)
        (@river + @hole).combination(5).collect(&block)
      end
  end
end
