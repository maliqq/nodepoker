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
    attr_reader :hand_cards
    attr_reader :hands_size

    def initialize(hands_size)
      @hands_size = hands_size
      @flop = []
      @hands = []
      @hand_cards = []
    end

    def shuffle
      deck = CARDS.shuffle
      3.times { @flop << deck.shift }
      @turn_card = deck.shift
      @river_card = deck.shift
      @hands_size.times { @hand_cards << [deck.shift, deck.shift] }
      @hands = @hand_cards.collect { |cards| Hand.new(river + cards) }
    end

    def inspect
      "<Table flop=#{flop} turn_card=#{turn_card} river_card=#{river_card}>"
    end

    def winner_hand
      @hands.max
    end

    def winner_hand_index
      @hands.index(winner_hand)
    end
  end
end
