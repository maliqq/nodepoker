module PokerNode
  class Card
    include Comparable

    attr_reader :kind, :suit

    def self.from_string(s)
      s.scan(REGEX).collect { |kind, suit|
        new(kind, suit)
      }
    end

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
      (KIND.index(self.kind) || -1) <=> (KIND.index(other.kind) || -1)
    end
  end
end
