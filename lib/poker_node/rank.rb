module PokerNode
  module Rank
    class HighCard
      include Comparable

      attr_reader :kickers
      attr_reader :high_cards
      
      def initialize(hand)
        @high_cards = hand.cards
        @kickers = hand.cards
      end
      
      def highest_kicker
        @kickers.max
      end

      def highest_card
        @high_cards.max
      end

      def to_s
        'High Card'
      end

      def to_sym
        :high_card
      end

      def inspect
        "<#{to_s} high_cards=#{high_cards} kickers=#{kickers}>"
      end

      def explain
        inspect
      end

      def index
        HAND.index(self.to_sym)
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

    class FourOfKind < HighCard
      def initialize(hand)
        @high_cards = hand.quad
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'Four of a Kind'
      end

      def to_sym
        :four_of_kind
      end
    end

    class ThreeOfKind < HighCard
      def initialize(hand)
        @high_cards = hand.set
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'Three of a Kind'
      end

      def to_sym
        :three_of_kind
      end
    end

    class TwoPair < HighCard
      def initialize(hand)
        pairs = hand.pairs_sorted.slice(0, 2)
        @high_cards = pairs.map(&:max)
        @kickers = hand.cards - pairs.flatten
      end

      def to_s
        'Two Pairs'
      end

      def to_sym
        :two_pair
      end
    end

    class FullHouse < HighCard
      def initialize(hand)
        full_house = [hand.set, hand.pair]
        @high_cards = full_house.map(&:max)
        @kickers = hand.cards - full_house.flatten
      end

      def to_s
        'Full House'
      end

      def to_sym
        :full_house
      end
    end

    class OnePair < HighCard
      def initialize(hand)
        pair = hand.pairs_sorted[0]
        @high_cards = pair
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'One Pair'
      end

      def to_sym
        :one_pair
      end
    end

    class Flush < HighCard
      def initialize(hand)
        @high_cards = hand.suit[hand.value]
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'Flush'
      end

      def to_sym
        :flush
      end
    end

    class Straight < HighCard
      def initialize(hand)
        @high_cards = hand.kind[hand.value]
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'Straight'
      end

      def to_sym
        :straight
      end
    end

    class StraightFlush < Flush
      def initialize(hand)
        @high_cards = hand.kind[hand.value.first]
        @kickers = hand.cards - @high_cards
      end

      def to_s
        'Straight Flush'
      end

      def to_sym
        :straight_flush
      end
    end
  end
end
