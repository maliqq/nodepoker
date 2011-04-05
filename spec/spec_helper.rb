require 'poker_node'
require 'active_support/core_ext/array'

def card(kind, suit)
  suits = %q(s h d c)
  PokerNode::Card.new(kind, PokerNode::SUIT[suits.index(suit)])
end
