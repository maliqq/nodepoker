$KCODE = 'u'

module PokerNode
  SUIT = %w(♠ ♥ ♦ ♣)
  KIND = %w(A K Q J 10 9 8 7 6 5 4 3 2)
  HAND = [ # sorted by rank
    :straight_flush,
    :four_of_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]
  REGEX = /(\d+|[A|K|Q|J]{1})([♠ ♥ ♦ ♣]{1})/

  class Suit
    class << self
      def random
        SUIT[rand(SUIT.size)]
      end
    end
  end

  class Hand
    def initialize(hand)
      @flush      = Hand.flush?(Hash[hand].values)
      @straight   = Hand.straight?(Hash[hand].keys)
      @kinds      = hand.collect { |card| card[0] }
      @counts     = @kinds.collect { |kind| @kinds.count(kind) }
      @four       = @counts.any? { |c| c == 4 }
      @three      = @counts.any? { |c| c ==3 }
      @pair       = @counts.any? { |c| c == 2 }
      @two_pairs  = @counts.select { |c| c == 2 }.size == 2
    end

    def <=>(other_hand) # TODO compare with other hand
    end

    def four?
      @four
    end

    def three?
      @three
    end

    def pair?
      @pair
    end

    def two_pairs?
      @two_pairs
    end

    def flush?
      @flush
    end

    def straight?
      @straight
    end

    class << self
      def flush?(suits)
        suits.uniq.size == 1
      end

      def straight?(kinds)
        kinds.uniq.size == 5 && begin
          indexes = kinds.collect { |kind| KIND.index(kind) }
          indexes.max - indexes.min == 4
        end
      end

      def detect(s)
        hand = new(s.scan(REGEX))
        return :straight_flush  if hand.straight? && hand.flush?
        return :four_of_kind    if hand.four?
        return :full_house      if hand.pair? && hand.three?
        return :flush           if hand.flush?
        return :straight        if hand.straight?
        return :tree_of_kind    if hand.three?
        return :two_pair        if hand.two_pairs?
        return :one_pair        if hand.pair?
        return :hight_card
      end
    end
  end

  class Table
    attr_reader :flop

    attr_reader :turn_card
    def turn
      "#{flop}#{turn_card}"
    end

    attr_reader :river_card
    def river
      "#{turn}#{river_card}"
    end

    attr_reader :hands
  end
end
