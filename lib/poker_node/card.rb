module PokerNode
  class Card
    include Comparable

    attr_reader :kind, :suit

    REGEX = /(\d+|[A|K|Q|J]{1})([♠♥♦♣]{1})/

    class << self
      def from_string(s)
        s.scan(REGEX).collect { |kind, suit|
          new(kind, suit)
        }
      end
      
      alias :parse! from_string
    end

    def initialize(kind, suit)
      @kind = kind
      @suit = suit
    end

    CARD = Suit.all.collect { |suit| # deck
      Kind.all.collect { |kind| Card.new(kind, suit) }
    }.flatten.freeze

    def self.all
      CARD
    end

    def self.size
      CARD.size
    end

    def self.shuffle
      all.shuffle
    end

    def to_s
      "#{@kind}#{@suit}"
    end

    def inspect
      "<Card:#{self}>"
    end

    def ==(other)
      other.is_a?(Card) && self.kind == other.kind && self.suit == other.suit
    end

    def <=>(other)
      Kind.index(self.kind) <=> Kind.index(other.kind)
    end
  end
end
