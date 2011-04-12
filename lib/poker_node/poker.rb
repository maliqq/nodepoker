module PokerNode
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

    module Holdem
      autoload :Deal, 'poker_node/holdem/deal'
      autoload :Hole, 'poker_node/holdem/hole'
    end
  end
end
