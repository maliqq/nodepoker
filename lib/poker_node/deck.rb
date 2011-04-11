module PokerNode
  class Deck
    def initialize
      @cards = Card.shuffle
    end

    def burn!
      @cards.shift
    end

    def size
      @cards.size
    end

    def random
      @cards[rand(@cards.size)]
    end

    def burn_random!
      @cards.delete(random)
    end

    def burn_random_kind!
      burn = random
      @cards.delete_if { |card| burn.kind == card.kind }
      burn
    end
  end
end
