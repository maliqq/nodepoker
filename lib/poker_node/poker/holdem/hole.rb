module PokerNode::Holdem
  class Hole
    SIZE = 2

    def self.size
      SIZE
    end

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
