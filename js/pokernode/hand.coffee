class Rank
    constructor: (data) ->
        @kind = data.kind
        @suit = data.suit
        @cards = data.cards

    toString: ->
        "[kind=" + this.kind + " suit=" + Suit.draw(this.suit) + " cards=" + this.cards.toString() + "]"

class Hand
    constructor: (@cards) ->
        @suits = {}
        @kinds = {}
        for suit in Suit.all
            @suits[suit] = []
        for kind in Kind.all
            @kinds[kind] = []
        for card in @cards
            @kinds[card.kind].push card
            @suits[card.suit].push card
    isStraightFlush: ->
        if @isStraight()
            value = @value
            cards = value[1].cards
            suit = null
            for card in cards
                if suit == null
                    suit = card.suit
                else if suit != card.suit
                    return false
            if suit?
                @value[0] = 'straight_flush'
                @value[1].suit = suit
                return true
        false

    isStraight: ->
        for i in [8..-1]
            slice = if i == -1
                ['A'].concat(Kind.all.slice(0, 4))
            else
                Kind.all.slice(i, i + 5)
            result = true
            cards = []
            for kind in slice
                present = false
                for card in @cards
                    if card.kind == kind
                        cards.push card
                        present = true
                unless present
                    result = false
                    break
            if result
                kind = Kind.all[i + 5]
                @value = ['straight', new Rank({kind: kind, cards: cards})]
                return true
        false

    isFlush: ->
        for suit in Suit.all
            cards = @suits[suit]
            if cards.length >= 5
                @value = ['flush', new Rank({suit: suit, cards: cards})]
                return true
        false

    isQuad: ->
        for kind in Kind.all
            cards = @kinds[kind]
            if cards.length == 4
                @value = ['quad', new Rank({kind: kind, cards: cards})]
                return true
        false

    isFullHouse: ->
        if this.isSet()
            value = @value
            if this.isPair()
                @value = ['full_house', [value[1], this.value[1]]]
                return true
        false

    isSet: ->
        for kind in Kind.all
            cards = @kinds[kind]
            if cards.length == 3
                @value = ['set', new Rank({kind: kind, cards: cards})]
                return true
        false

    isDoper: ->
        total = 0
        value = []
        for kind in Kind.all
            cards = @kinds[kind]
            if cards.length == 2
                value.push [kind, cards]
                total++
        if total == 2
            @value = ['doper', []]
            for v in value
                this.value[1].push new Rank({kind: v[0], cards: v[1]})
            return true
        false

    isPair: ->
        for kind in Kind.all
            cards = @kinds[kind]
            if cards.length == 2
                @value = ['pair', new Rank({kind: kind, cards: cards})]
                return true
        false

    isHighCard: ->
        @value = ['high_card', new Rank({cards:this.cards})]
        true

Hand.detect = (hand)->
    while true
        break if hand.isStraightFlush()
        break if hand.isQuad()
        break if hand.isFullHouse()
        break if hand.isFlush()
        break if hand.isStraight()
        break if hand.isSet()
        break if hand.isDoper()
        break if hand.isPair()
        break if hand.isHighCard()
    hand.value[0]
