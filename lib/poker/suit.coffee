Suit = ->
Suit.all = ['s', 'h', 'd', 'c']
Suit.chars = ['♠', '♥', '♦', '♣']
Suit.names = ['spades', 'hearts', 'diamonds', 'clubs']
Suit.entities = ['&spades;', '&hearts;', '&diams;', '&clubs;']

Suit.indexOf = (suit) ->
  Suit.all.indexOf(suit)

Suit.charOf = (suit) ->
  Suit.chars[Suit.indexOf(suit)]

Suit.nameOf = (suit) ->
  Suit.names[Suit.indexOf(suit)]

Suit.entityOf = (suit) ->
  Suit.entities[Suit.indexOf(suit)]

exports.Suit = Suit

