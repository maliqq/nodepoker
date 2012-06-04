Kind = require(__dirname + '/kind').Kind
Suit = require(__dirname + '/suit').Suit

class Card
  constructor: (@kind, @suit) ->
  toString: ->
    @kind + Suit.charOf(@suit)

Card.from_string = (s) ->
  (kind, suit) = s.split //
  new Card(kind, suit)

Card.deck = ->
  cards = []
  for suit in Suit.all
    for kind in Kind.all
      cards.push new Card(kind, suit)
  cards

Card.all = Card.deck()

Card.shuffle = ->
  Card.build_deck().sort () -> return 0.5 - Math.random()

Card.parse = (s)->
  Card.from_string(c) for c in s.match /([AKQJT2-9]{1}[shdc]{1})/g

exports.Card = Card
