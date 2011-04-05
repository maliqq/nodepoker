module PokerNode
  class Deal
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
    attr_reader :hole_cards
    attr_reader :holes
    attr_reader :limit

    def initialize(limit)
      @flop = []
      @hands = []
      @hole_cards = []
      @holes = []
      @limit = limit
    end

    def shuffle
      deck = CARDS.shuffle
      3.times { @flop << deck.shift }
      @turn_card = deck.shift
      @river_card = deck.shift
      @limit.times { @hole_cards << [deck.shift, deck.shift] }
      @holes = @hole_cards.collect { |hole| Hole.new(river, hole) }
      @hands = @holes.map(&:hand)
    end

    def winning_hand
      @hands.max
    end

    def winning_hand_index
      @hands.index(winning_hand)
    end

    def inspect
      "<Table flop=#{flop} turn_card=#{turn_card} river_card=#{river_card}>"
    end
  end
end
