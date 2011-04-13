require 'set'

module PokerNode
  class Hand
    attr_reader :cards

    attr_reader :suit
    attr_reader :kind
    attr_reader :flush_suit
    attr_reader :straight_kind
    
    def initialize(cards)
      @cards = cards.is_a?(String) ? Card.parse!(cards) : cards
    end

    def kind
      @kind ||= @cards.group_by(&:kind)
    end

    def kinds
      @kinds ||= @cards.map(&:kind)
    end

    def kinds_set
      Set.new(kinds)
    end

    def straight_kind
      Kind.straights.each { |kinds|
        @straight_kind = kinds.last if Set.new(kinds).subset?(kinds_set)
      }
      @straight_kind
    end

    def suit
      @suit ||= @cards.group_by(&:suit)
    end
    
    def suits
      @suits ||= @cards.map(&:suit)
    end

    def flush_suit
      @flush_suit ||= suits.select { |suit| self.suit[suit].size >= 5 }.first
    end

    def cards_by_count(n)
      kind.values.select { |cards| cards.size == n }
    end

    def high_card?
      true
    end

    def straight_flush?
      straight? && flush?
    end

    def royal_flush?
      straight_flush? && straight_kind == 'A'
    end

    def flush?
      flush_suit.present?
    end

    def straight?
      straight_kind.present?
    end
    
    def wheel_straight?
      straight? && straight_kind == '5'
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

    def query?(hand)
      send("#{hand}?")
    end
    
    alias :pair? one_pair?
  end
  
  class HighCard
    include Comparable
    
    attr_reader :hand
    attr_reader :high_cards
    attr_reader :kickers

    def initialize(hand, hole)
      @hand = hand
      @hole = hole
    end

    def hole_cards
      @hole.cards
    end

    def high_cards
      @hole.cards
    end

    def kickers
      @hand.cards - high_cards
    end

    def name
      self.class.to_s.demodulize.underscore
    end

    def explain
      "High card #{@hole.cards.max}"
    end

    def inspect
      "<Rank:#{explain}\n\thole_cards=#{hole_cards}\n\thigh_cards=#{high_cards}\n\tkickers=#{kickers}>"
    end

    def index
      PokerNode::Poker::HIGH.index(name.to_sym)
    end

    def <=>(other)
      index_compare = self.index <=> other.index
      return index_compare unless index_compare == 0
      self.high_cards.each_with_index { |card, i|
        high_card_compare = card <=> other.high_cards[i]
        return high_card_compare unless high_card_compare == 0
      }
      self.kickers.each_with_index { |card, i|
        kicker_compare = card <=> other.kickers[i]
        return kicker_compare unless kicker_compare == 0
      }
      return 0
    end
  end

  class Flush < HighCard
    def high_cards
      @hand.suit[@hand.flush_suit]
    end

    def explain
      "Flush of #{@hand.flush_suit}"
    end
  end

  class Straight < HighCard
    def high_cards
      @hand.kind[@hand.straight_kind]
    end

    def explain
      "Straight to #{@hand.straight_kind}"
    end
  end

  class StraightFlush < Straight
    def explain
      "Straight flush of #{@hand.flush_suit} to #{@hand.straight_kind}"
    end
  end

  class FourOfKind < HighCard
    def high_cards
      @hand.quad
    end

    def explain
      "Four of #{@hand.quad.max.kind}'s"
    end
  end

  class ThreeOfKind < HighCard
    def high_cards
      @hand.set
    end

    def explain
      "Three of #{high_cards.max.kind}'s"
    end
  end

  class FullHouse < ThreeOfKind
    def explain
      "#{@hand.set.max.kind}'s full of #{@hand.pair.max.kind}'s"
    end
  end

  class OnePair < HighCard
    def high_cards
      @hand.pair
    end

    def explain
      "Pair of #{@hand.pair.max.kind}'s"
    end
  end

  class TwoPair < OnePair
    def high_cards
      @hand.pair
    end

    def explain
      "Pairs of #{@hand.pairs_sorted.first.max.kind}'s and #{@hand.pairs_sorted.second.max.kind}'s"
    end
  end
end
