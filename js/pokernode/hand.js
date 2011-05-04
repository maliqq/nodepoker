Rank = function(data) {
    this.kind = data.kind
    this.suit = data.suit
    this.cards = data.cards

    this.toString = function() {
        return "[kind=" + this.kind + " suit=" + Suit.draw(this.suit) + " cards=" + this.cards.toString() + "]"
    }
}

Hand = function(cards) {
    this.suits = {}
    for (var i = 0; i < cards.length; i++) {
        var card = cards[i]
        if (typeof(this.suits[card.suit]) == 'undefined') {
            this.suits[card.suit] = []
        }
        this.suits[card.suit].push(card)
    }
    
    this.kinds = {}
    for (i = 0; i < cards.length; i++) {
        card = cards[i]
        if (typeof(this.kinds[card.kind]) == 'undefined') {
            this.kinds[card.kind] = []
        }
        this.kinds[card.kind].push(card)
    }
    this.cards = cards

    this.isStraightFlush = function() {
        if (this.isStraight()) {
            var value = this.value
            var cards = value[1].cards
            var suit = null
            for (var i = 0; i < cards.length; i++) {
                var card = cards[i]
                if (suit == null)
                    suit = card.suit
                else if (suit != card.suit)
                    return false
            }
            this.value[0] = 'straight_flush'
            this.value[1].suit = suit
            return true
        }
        return false
    }

    this.isStraight = function() {
        for (var i = 8; i >= -1; i--) {
            var slice = null
            if (i == -1) {
                slice = ['A'].concat(Kind.all.slice(0, 4))
            } else {
                slice = Kind.all.slice(i, i + 5)
            }
            var result = true
            var cards = []
            for (var j = 0; j < 5; j++) {
                var kind = slice[j]
                var present = false
                for (var k = 0; k < this.cards.length; k++) {
                    var card = this.cards[k]
                    if (card.kind == kind) {
                        cards.push(card)
                        present = true
                    }
                }
                if (!present) {
                    result = false
                    break
                }
            }
            if (result) {
                kind = Kind.all[i + 5]
                this.value = ['straight', new Rank({kind: kind, cards: cards})]
                return true
            }
        }
        return false
    }

    this.isFlush = function() {
        for (var i = 0; i < Suit.all.length; i++) {
            var suit = Suit.all[i]
            var cards = this.suits[suit]
            if (typeof(cards) == 'undefined')
                continue
            if (cards.length >= 5) {
                this.value = ['flush', new Rank({suit: suit, cards: cards})]
                return true
            }
        }
        return false
    }

    this.isQuad = function() {
        for (var i = 0; i < Kind.all.length; i++) {
            var kind = Kind.all[i]
            var cards = this.kinds[kind]
            if (typeof(cards) == 'undefined')
                continue
            if (cards.length == 4) {
                this.value = ['quad', new Rank({kind: kind, cards: cards})]
                return true
            }
        }
        return false
    }

    this.isFullHouse = function() {
        if (this.isSet()) {
            var value = this.value
            if (this.isPair()) {
                this.value = ['full_house', [value[1], this.value[1]]]
                return true
            }
        }
        return false
    }

    this.isSet = function() {
        for (var i = 0; i < Kind.all.length; i++) {
            var kind = Kind.all[i]
            var cards = this.kinds[kind]
            if (typeof(cards) == 'undefined')
                continue
            if (cards.length == 3) {
                this.value = ['set', new Rank({kind: kind, cards: cards})]
                return true
            }
        }
        return false
    }

    this.isDoper = function() {
        var total = 0
        var value = []
        for (var i = 0; i < Kind.all.length; i++) {
            var kind = Kind.all[i]
            var cards = this.kinds[kind]
            if (typeof(cards) == 'undefined')
                continue
            if (cards.length == 2) {
                value.push([kind, cards])
                total++
            }
        }
        if (total == 2) {
            this.value = ['doper', []]
            for (i = 0; i < value.length; i++) {
                this.value[1].push(new Rank({kind: value[i][0], cards: value[i][1]}))
            }
            return true
        }
        return false
    }

    this.isPair = function() {
        for (var i = 0; i < Kind.all.length; i++) {
            var kind = Kind.all[i]
            var cards = this.kinds[kind]
            if (typeof(cards) == 'undefined')
                continue
            if (cards.length == 2) {
                this.value = ['pair', new Rank({kind: kind, cards: cards})]
                return true
            }
        }
        return false
    }

    this.isHighCard = function() {
        this.value = ['high_card', new Rank({cards:this.cards})]
        return true
    }
}

Hand.detect = function(hand) {
    while(1) {
        if (hand.isStraightFlush()) break
        if (hand.isQuad()) break
        if (hand.isFullHouse()) break
        if (hand.isFlush()) break
        if (hand.isStraight()) break
        if (hand.isSet()) break
        if (hand.isDoper()) break
        if (hand.isPair()) break
        if (hand.isHighCard()) break
    }
    return hand.value[0]
}
