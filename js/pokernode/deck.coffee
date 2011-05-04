class Deck
    constructor: ->
        @cards = Card.shuffle()
    burn: ->
        @cards.shift()
