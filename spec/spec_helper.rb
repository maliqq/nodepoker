$KCODE = 'u'

require 'poker_node'
require 'active_support/all'

include PokerNode

def Card(s)
  Card.parse!(s)
end

def Rand(s)
  Card(Rand.generate!(s))
end
