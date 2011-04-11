module PokerNode::Holdem
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
      @deck = Deck.new
    end

    def shuffle
      @flop.fill(0, 3) { @deck.burn! }
      @turn_card = @deck.burn!
      @river_card = @deck.burn!
      @limit.times { @hole_cards << deal_hole }
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

    private

      def deal_hole
        [].fill(0, Hole.size) { @deck.burn! }
      end
  end
end
