module PokerNode
  class Hand
    attr_reader :cards
    attr_reader :flush_suit
    attr_reader :straight_to
    
    def initialize(cards)
      @cards = cards.is_a?(String) ? Card.parse!(cards) : cards
      @kinds = cards.map(&:kind)
      @kinds_hash = cards.group_by(&:kind)
      @suits = cards.map(&:suit)
      @suits_hash = cards.group_by(&:suit)
      @flush_suit = @suits.select { |suit| @suits_hash[suit].size >= 5 }.first
      Kind.straights.each { |kinds|
        if kinds.all? { |kind| @kinds.include?(kind) }
          @straight_to = kinds.last
        end
      }
    end

    def suit
      @suits_hash
    end

    def kind
      @kinds_hash
    end

    def cards_by_count(n)
      @kinds_hash.values.select do |cards|
        cards.size == n
      end
    end

    def high_card?
      true
    end

    def wheel_straight?
      straight? && @straight_to == '5'
    end

    def straight_flush?
      straight? && flush?
    end

    def royal_flush?
      straight_flush? && @straight_to == 'A'
    end

    def flush?
      @flush_suit.present?
    end

    def straight?
      @straight_to.present?
    end

    def quads
      cards_by_count(4)
    end

    def quad
      quads.first
    end

    def four_of_kind?
      quad.present?
    end

    def full_house?
      set? && pair?
    end

    def sets
      cards_by_count(3)
    end

    def set
      sets.first
    end

    def three_of_kind?
      set.present?
    end

    alias :set? three_of_kind?

    def pairs
      @pairs ||= cards_by_count(2)
    end

    def pairs_sorted
      pairs.sort_by(&:max)
    end

    def pair
      pairs_sorted.first
    end

    def two_pair? # at least 2 pairs
      pairs.size >= 2
    end

    def one_pair? # at least 1 pair
      !pairs.empty?
    end
    
    alias :pair? one_pair?
  end
  
  class HighCard
    attr_reader :hand
    attr_reader :high_cards
    attr_reader :kickers

    def initialize(hand)
      @hand = hand
    end
  end

  class Flush < HighCard
    def high_cards
      @hand.suit[@hand.flush_suit]
    end
  end

  class Straight < HighCard
    def high_cards
      @hand.kind[@hand.straight_to]
    end
  end

  class StraightFlush < Straight
  end

  class FourOfKind < HighCard
    def high_cards
      @hand.quad
    end
  end

  class ThreeOfKind < HighCard
    def high_cards
      @hand.set
    end
  end

  class FullHouse < ThreeOfKind
  end

  class OnePair < HighCard
    def high_cards
      @hand.pair
    end
  end

  class TwoPair < OnePair
    def high_cards
      @hand.pair
    end
  end
end
