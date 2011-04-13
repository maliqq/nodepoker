module PokerNode
  autoload :Suit, 'poker_node/suit'
  autoload :Kind, 'poker_node/kind'
  autoload :Card, 'poker_node/card'
  autoload :Hand, 'poker_node/hand'
  autoload :Deck, 'poker_node/deck'
  autoload :Rand, 'poker_node/rand'

  autoload :Poker, 'poker_node/poker' # general poker
  autoload :Holdem, 'poker_node/poker' # texas holdem
  autoload :Omaha, 'poker_node/poker' # omaha high
  autoload :Stud, 'poker_node/poker' # 7-card stud high
  autoload :Razz, 'poker_node/poker' # or 7-card stud low
end
