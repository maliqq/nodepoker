module PokerNode
  class Suit
    SUIT = %w(♠ ♥ ♦ ♣).freeze

    def self.all
      SUIT
    end

    def self.wrap(suit)
      w = %w(s h d c)
      suit = SUIT[w.index(suit)] if w.include?(suit)
      suit
    end
  end
end
