module PokerNode
  class Hand
    include Comparable

    attr_reader :cards
    attr_reader :value
    attr_reader :rank

    def initialize(cards)
      @cards = cards.is_a?(String) ? Card.from_string(cards) : cards
      #raise ArgumentError.new('only 5 cards for one hand allowed') if @cards.size > 5
      hand_rank, @value = *Test.detect(@cards)
      @rank = "PokerNode::Rank::#{hand_rank.to_s.classify}".constantize.new(self)
    end

    delegate :explain, :to => :rank

    def suit
      @suit ||= @cards.group_by(&:suit)
    end

    def kind
      @kind ||= @cards.group_by(&:kind)
    end

    def quads
      cards_by_count(4)
    end

    def sets
      cards_by_count(3)
    end

    def pairs
      cards_by_count(2)
    end

    def quad
      quads.first
    end

    def set
      sets.first
    end

    def pairs_sorted
      pairs.sort_by(&:max)
    end

    def pair
      pairs_sorted.first
    end

    def <=>(other)
      self.rank <=> other.rank
    end

    private

      def cards_by_count(n)
        kind.values.select { |cards| cards.size == n }
      end
  end
end
