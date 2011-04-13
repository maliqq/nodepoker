module PokerNode
  module Holdem
    autoload :Deal, 'poker_node/holdem/deal'
    autoload :Hole, 'poker_node/holdem/hole'
  end

  module Omaha
    autoload :Deal, 'poker_node/omaha/deal'
    autoload :Hole, 'poker_node/omaha/hole'
  end

  module Poker
    HIGH = [
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

    LOW = [] # for razz
  end
end
