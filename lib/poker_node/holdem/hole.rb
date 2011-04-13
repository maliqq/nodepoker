module PokerNode::Holdem
  class Hole
    SIZE = 2

    def self.size
      SIZE
    end

    attr_reader :river
    attr_reader :cards
    
    attr_reader :hand

    def initialize(river, cards)
      @river = river
      @cards = cards
    end

    def hand
      @hand ||= PokerNode::Hand.new(@river + @cards)
    end

    def rank
      @rank ||= "PokerNode::#{hand_rank.to_s.classify}".constantize.new(@hand, self)
    end

    def hand_rank
      PokerNode::Poker::HIGH.reverse.each { |high|
        return high if hand.query?(high)
      }
    end
  end
end
