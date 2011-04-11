module PokerNode
  module Poker
    HIGH_HAND = [
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

    LOW_HAND = [] # for razz
  end
end
