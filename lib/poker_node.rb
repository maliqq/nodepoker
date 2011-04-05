require 'set'

$KCODE = 'u'

module PokerNode
  autoload :Card, 'poker_node/card'
  autoload :Hand, 'poker_node/hand'
  autoload :Hole, 'poker_node/hole'
  autoload :Deal, 'poker_node/deal'
  autoload :Rank, 'poker_node/rank'
  autoload :Test, 'poker_node/test'

  SUIT = %w(♠ ♥ ♦ ♣).freeze

  KIND = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze

  HAND = [ # sorted by rank
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

  CARDS = SUIT.collect { |suit| # deck
    KIND.collect { |kind| Card.new(kind, suit) }
  }.flatten.freeze

  REGEX = /(\d+|[A|K|Q|J]{1})([♠♥♦♣]{1})/
end
