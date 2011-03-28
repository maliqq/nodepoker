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
  REGEX = /(\d+|[A|K|Q|J]{1})([♠♥♦♣]{1})/

  class Hand
    def initialize(hand)
      case hand
      when Hash
        hand = hand.to_a
      when String
        hand = hand.scan(REGEX)
      end
      @hand = Hash[hand]

      @kinds      = hand.collect { |card| card[0] }
      @suits      = hand.collect { |card| card[1] }
      
      @flush      = Hand.flush?(@suits)
      @straight   = Hand.straight?(@kinds)

      @counts     = @kinds.uniq.collect { |kind| @kinds.count(kind) }

      @four       = @counts.any? { |c| c == 4 }
      @three      = @counts.any? { |c| c == 3 }
      @pair       = @counts.any? { |c| c == 2 }
      @two_pairs  = @counts.select { |c| c == 2 }.size == 2
    end

    def <=>(other_hand)
      rank == other_hand.rank ? weight <=> other_hand.weight : rank <=> other_hand.rank
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

    def to_sym
      return :straight_flush  if straight? && flush?
      return :four_of_kind    if four?
      return :full_house      if pair? && three?
      return :flush           if flush?
      return :straight        if straight?
      return :tree_of_kind    if three?
      return :two_pair        if two_pairs?
      return :one_pair        if pair?
      return :high_card
    end
    
    def rank
      @rank ||= HAND.index(to_sym)
    end

    def weight # TODO
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
