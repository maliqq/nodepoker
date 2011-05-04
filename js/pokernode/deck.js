Deck = function() {
    this.cards = Card.shuffle()
    this.burn = function() {
        return this.cards.shift()
    }
}
