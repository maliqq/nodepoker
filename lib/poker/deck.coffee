Card = require(__dirname + "/deck/card").Card;

class Deck
  constructor: ->
    @cards = Card.shuffle()
  burn: ->
    @cards.shift()
