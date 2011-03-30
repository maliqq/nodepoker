module PokerNode
  class Hand
    include Comparable

    attr_reader :cards
    attr_reader :high_card
    attr_reader :kickers

    def initialize(cards)
      @cards = cards
      @cards = Card.from_string(cards) if cards.is_a?(String)
      @cards_by_suit = Hash.new { |h, k| h[k] = [] }
      @cards_by_kind = Hash.new { |h, k| h[k] = [] }
      @cards.each { |card|
        @cards_by_suit[card.suit] << card
        @cards_by_kind[card.kind] << card
      }
      @high_card = Card.new(nil, nil)
      @kickers = on_hand
    end

    def four_of_kind?
      quads = @cards_by_kind.values.select { |cards|
        cards.size == 4
      }
      if quads.first
        @high_card = quads[0].first
        @kickers = @cards - quads
      end
      quads.size > 0
    end

    def three_of_kind?
      set = @cards_by_kind.values.select { |cards|
        cards.size == 3
      }
      if set.first
        @high_card = set[0].first
        @kickers = @cards - set
      end
      set.size > 0
    end

    alias :set? three_of_kind?

    def two_pair?
      p = sorted_pairs
      if p.first && p.second
        @high_card = p.first.max
        @kickers = @cards - sorted_pairs.flatten
        @kickers += p.third if p.third
      end
      p.size > 1
    end

    def one_pair?
      p = sorted_pairs
      if p.first
        @high_card = p.first.max
        @kickers = @cards - p.first
      end
      p.size > 0
    end

    alias :pair? one_pair?

    def flush?
      f = @cards_by_suit.values.select { |cards|
        cards.size == 5
      }
      if f.first
        @high_card = f.first.max
        @kickers = @cards - f.first
      end
      f.size > 0
    end

    def straight?
      12.downto(3) { |i|
        straight_kinds = if i == 3
          KIND.slice(0, 4).unshift(KIND[12]) # wheel
        else
          KIND.slice(i - 4, 5)
        end
        if straight_kinds.all? { |kind|
          @cards_by_kind[kind].size > 0
        }
          @high_card = @cards_by_kind[KIND[i]].first
          @kickers = @cards - straight_kinds.collect { |kind| @cards_by_kind[kind].first }
          return true
        end
      }
      return false
    end

    def straight_flush?
      straight? && @cards_by_suit[@high_card.suit].size == 5
    end

    def full_house?
      pair? && three_of_kind?
    end

    def high_card?
      true
    end

    def pairs
      @cards_by_kind.values.select { |cards|
        cards.size == 2
      }
    end

    def sorted_pairs
      pairs.sort_by(&:max)
    end

    def hand_rank
      HAND.reverse.each { |hand|
        return hand if __send__("#{hand}?")
      }
    end

    def rank
      @rank ||= hand_rank
    end

    def rank_index
      HAND.index(rank)
    end

    def to_s
      "#{rank}"
    end

    def inspect
      "<Hand:#{@cards.slice(-2, 2)}>"
    end

    def explain
      case rank
      when :straight_flush
        "Straight flush to #{@high_card.kind}"
      when :straight
        "Straight to #{@high_card.kind}"
      when :flush
        "Flush to #{@high_card.kind}"
      when :full_house
        "Full House of #{@high_card.kind} and #{sorted_pairs.first[0].kind}"
      when :four_of_kind
        "Four of #{@high_card.kind}"
      when :three_of_kind
        "Three of #{@high_card.kind}"
      when :two_pair
        "Two pairs of #{sorted_pairs.first[0].kind} and #{sorted_pairs.second[0].kind}"
      when :one_pair
        "One pair of #{pairs.first[0].kind}"
      when :high_card
        "High card"
      end + ", kicker #{@kickers.max}"
    end

    def on_hand
      @cards.slice(-2, 2)
    end

    def kickers_sum
      @kickers.inject(0) { |sum, card|
        sum + KIND.index(card.kind)
      }
    end

    def <=>(other)
      if self.rank_index == other.rank_index
        if self.high_card == other.high_card
          self.kickers_sum <=> other.kickers_sum
        else
          self.high_card <=> other.high_card
        end
      else
        self.rank_index <=> other.rank_index
      end
    end
  end
end
