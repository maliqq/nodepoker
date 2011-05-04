Card = function(kind, suit) {
    this.kind = kind
    this.suit = suit
    this.toString = function() {
        return this.kind + Suit.draw(this.suit)
    }
}

Card.all = function() {
    cards = []
    for (var i = 0; i < Suit.all.length; i++) {
        for (var j = 0; j < Kind.all.length; j++) {
            cards.push(new Card(Kind.all[j], Suit.all[i]))
        }
    }
    return cards
}()

Card.shuffle = function() {
    var cards = Card.all
    cards.sort(function() {return 0.5 - Math.random()})
    return cards
}
