module PokerNode
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
end
