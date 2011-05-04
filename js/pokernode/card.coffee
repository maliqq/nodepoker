class Card
    constructor: (@kind, @suit) ->
    toString: ->
        this.kind + Suit.draw this.suit

Card.all = ->
    cards = []
    for suit in Suit.all
        for kind in Kind.all
            cards.push(new Card(kind, suit))
    cards

Card.shuffle = ->
    Card.all().sort () -> return 0.5 - Math.random()
