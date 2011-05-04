Deal = function(size) {
    deck = new Deck()
    this.flop = []
    for (var i = 0; i < 3; i++) {
        this.flop.push(deck.burn())
    }
    this.turn_card = deck.burn()
    this.turn = function() {
        return this.flop.concat([this.turn_card])
    }
    this.river_card = deck.burn()
    this.river = function() {
        return this.turn().concat([this.river_card])
    }
    this.size = size
    this.hole_cards = []
    for (i = 0; i < this.size; i++) {
        var cards = [deck.burn(), deck.burn()]
        this.hole_cards.push(cards)
    }
    this.hands = []
    for (i = 0; i < this.size; i++) {
        var hole = this.hole_cards[i]
        var hand = new Hand(this.river().concat(hole))
        this.hands.push(hand)
    }
    
    this.toString = function() {
        var holes = ""
        for (var i = 0; i < this.size; i++) {
            var hole = this.hole_cards[i]
            Hand.detect(this.hands[i])
            holes += "\thole " + (i + 1) + ": " + hole.toString() +
                " | " + this.hands[i].value + "\n"
        }
        return "river: " + this.river().toString() + "\n" + holes
    }
}
