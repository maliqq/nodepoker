require 'set'

$KCODE = 'u'

module PokerNode
  SUIT = %w(♠ ♥ ♦ ♣).freeze
  
  KIND = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze

  HAND = [ # sorted by rank
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_kind,
    :straight_flush
  ].freeze

  class Card
    include Comparable
    
    attr_reader :kind, :suit
    
    def initialize(kind, suit)
      @kind = kind
      @suit = suit
    end

    def to_s
      "#{@kind}#{@suit}"
    end

    def inspect
      "<Card:#{self}>"
    end

    def <=>(other)
      KIND.index(self.kind) <=> KIND.index(other.kind)
    end
  end

  CARDS = SUIT.collect { |suit|
    
    KIND.collect { |kind| Card.new(kind, suit) }

  }.flatten.freeze

  REGEX = /(\d+|[A|K|Q|J]{1})([♠♥♦♣]{1})/

  class Hand
    attr_reader :cards

    def initialize(cards)
      @cards = cards.scan(REGEX).collect { |card|
        Card.new(card[0], card[1])
      }
      @cards_by_suit = Hash.new { |h, k| h[k] = [] }
      @cards_by_kind = Hash.new { |h, k| h[k] = [] }
      @cards.each { |card|
        @cards_by_suit[card.suit] << card
        @cards_by_kind[card.kind] << card
      }
    end

    def quads?
      @cards_by_kind.any? { |kind, cards|
        cards.size == 4
      }
    end

    def set?
      @cards_by_kind.any? { |kind, cards|
        cards.size == 3
      }
    end

    def two_pairs?
      @cards_by_kind.select { |kind, cards|
        cards.size == 2
      }.size >= 2
    end

    def pair?
      @cards_by_kind.any? { |kind, cards|
        cards.size == 2
      }
    end

    def flush?
      @cards_by_suit.any? { |suit, cards|
        cards.size == 5
      }
    end

    def straight?
      12.downto(4) { |i|
        straight_kinds = KIND.slice(i - 4, 5)
        return true if straight_kinds.all? { |kind|
          @cards_by_kind[kind].size > 0
        }
      }
      return false
    end

    def to_sym
      return :straight_flush  if straight? && flush?
      return :four_of_kind    if quads?
      return :full_house      if pair? && set?
      return :flush           if flush?
      return :straight        if straight?
      return :tree_of_kind    if set?
      return :two_pair        if two_pairs?
      return :one_pair        if pair?
      return :high_card
    end
    
    def rank
      @rank ||= HAND.index(to_sym)
    end
  end

  class Table
    attr_reader :flop

    attr_reader :turn_card
    def turn
      flop + [turn_card]
    end

    attr_reader :river_card
    def river
      turn + [river_card]
    end

    attr_reader :hands
    attr_reader :hands_size

    def initialize(hands_size)
      @hands_size = hands_size
      @flop = []
      @hands = []
    end

    def shuffle
      cards = CARDS.shuffle
      3.times { @flop << cards.shift }
      @turn_card = cards.shift
      @river_card = cards.shift
      @hands_size.times { @hands << [cards.shift, cards.shift] }
    end

    def inspect
      "<Table flop=#{flop} turn_card=#{turn_card} river_card=#{river_card}>"
    end
  end
end
