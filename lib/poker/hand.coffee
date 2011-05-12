Kind = require(__dirname + '/kind').Kind
Suit = require(__dirname + '/suit').Suit

class Rank
    constructor: (data) ->
        @kind = data.kind
        @suit = data.suit
        @cards = data.cards
        @kickers = data.kickers

    toString: ->
        "[kind=" + @kind + " suit=" + Suit.draw(@suit) + " cards=" + @cards.toString() + " kickers=" + @kickers +  "]"

class HighCard
    constructor: (data) ->
        @rank = if data.cards?
            new Rank(data)
        else
            data
    name: -> "high_card"
    toString: ->
        @name() + "::" + @rank.toString()

class StraightFlush extends HighCard
    name: -> "straight_flush"

class Quad extends HighCard
    name: -> "quad"

class FullHouse extends HighCard
    name: -> "full_house"

class Flush extends HighCard
    name: -> "flush"

class Straight extends HighCard
    name: -> "straight"

class Set extends HighCard
    name: -> "set"

class Doper extends HighCard
    name: -> "doper"

class Pair extends HighCard
    name: -> "pair"

class LowCard extends HighCard
    lo: ->
        kinds = (card.kind for card in @rank)
        lo = []
        for kind in Kind.low
            lo.push kind if kinds.indexOf(kind) != -1
        lo
    name: ->
        "lo"
    toString: ->
        @name() + "::" + @lo().toString()

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
            cards = value.rank.cards
            suit = null
            for card in cards
                if suit == null
                    suit = card.suit
                else if suit != card.suit
                    return false
            if suit?
                @value = new StraightFlush(@value.rank)
                @value.rank.suit = suit
                return true
        false

    isStraight: ->
        for i in [8..-1]
            slice = if i == -1
                ['A'].concat(Kind.all.slice(0, 4))
            else
                Kind.all.slice i, i + 5
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
                @value = new Straight({kind: kind, cards: cards})
                return true
        false

    isFlush: ->
        for suit, cards of @suits
            if cards.length >= 5
                @value = new Flush({suit: suit, cards: cards})
                return true
        false

    isQuad: ->
        for kind, cards of @kinds
            if cards.length == 4
                @value = new Quad({kind: kind, cards: cards})
                return true
        false

    isFullHouse: ->
        if this.isSet()
            value = @value
            if this.isPair() || this.isDoper()
                @value = new FullHouse([value.rank, this.value.rank])
                return true
        false

    isSet: ->
        for kind, cards of @kinds
            if cards.length == 3
                @value = new Set({kind: kind, cards: cards})
                return true
        false

    isDoper: ->
        total = 0
        value = []
        for kind, cards of @kinds
            if cards.length == 2
                value.push [kind, cards]
                total++
        if total >= 2
            @value = new Doper([])
            for v in value
                @value.rank.push new Rank({kind: v[0], cards: v[1]})
            return true
        false

    isPair: ->
        for kind, cards of @kinds
            if cards.length == 2
                @value = new Pair({kind: kind, cards: cards})
                return true
        false

    isHighCard: ->
        @value = new HighCard(@cards)
        true

    isLowCard: ->
        @value = new LowCard(@cards)
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
    hand.value.name()

exports.Hand = Hand

