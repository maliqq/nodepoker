module PokerNode
  class Omaha::Deal < Holdem::Deal
    def deal_hole
      [].fill(0, 4) { @deck.burn! }
    end

    def build_hole(hole)
      hole.combination(2).collect do |cards|
        PokerNode::Omaha::Hole.new(river, cards)
      end.sort_by(&:rank).last
    end
  end
end
