module PokerNode
  module Test
    class << self
      def detect(cards)
        HAND.reverse.each do |hand|
          test_result = Test.send("#{hand}?", cards)
          return [hand, test_result] unless test_result === false
        end
      end

      def four_of_kind?(cards)
        kinds = cards.map(&:kind).uniq
        kinds.each { |kind| return kind if cards.count { |i| i.kind == kind } == 4 }
        return false
      end

      def three_of_kind?(cards)
        kinds = cards.map(&:kind).uniq
        kinds.each { |kind| return kind if cards.count { |i| i.kind == kind } == 3 }
        return false
      end

      alias :set? three_of_kind?

      def two_pair?(cards)
        kinds = cards.map(&:kind).uniq
        paired_kinds = kinds.select { |kind| cards.count { |i| i.kind == kind } == 2 }
        return paired_kinds if paired_kinds.size == 2
        return false
      end

      def one_pair?(cards)
        kinds = cards.map(&:kind).uniq
        paired_kinds = kinds.select { |kind| cards.count { |i| i.kind == kind } == 2 }
        return paired_kinds.first if paired_kinds.first
        return false
      end

      alias :pair? one_pair?

      def flush?(cards)
        suits = cards.map(&:suit).uniq
        suits.each { |suit| return suit if cards.count { |i| i.suit == suit } >= 5 }
        return false
      end

      def straight?(cards)
        (3..12).to_a.reverse.each { |i|
          kinds = cards.map(&:kind).uniq
          straight_kinds = if i == 3
            KIND.slice(0, 4).unshift('A') # wheel
          else
            KIND.slice(i - 4, 5)
          end
          return KIND[i] if straight_kinds.all? { |kind| kinds.include?(kind) }
        }
        return false
      end

      def straight_flush?(cards)
        kind = straight?(cards)
        suit = flush?(cards)
        return [kind, suit] if kind && suit
        return false
      end

      def full_house?(cards)
        set = three_of_kind?(cards)
        pair = pair?(cards)
        return [set, pair] if set && pair
        return false
      end

      def high_card?(cards)
        return cards.max.kind
      end
    end
  end
end
