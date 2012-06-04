Kind = require(__dirname + '/kind').Kind
Suit = require(__dirname + '/suit').Suit

class Rank
  constructor: (data) ->
    @high = data.high
    @cards = data.cards
    @value = data.value
    @kickers = data.kickers
  toString: ->
    "[high=" + @high.toString() + " cards=" + @cards.toString() + " value=" + @value.toString() + " kickers=" + @kickers.toString() +  "]"

class HighCard
  constructor: (data) ->
    @rank = new Rank(data)
  name: -> "high_card"

class StraightFlush extends HighCard
  name: -> "straight_flush"

class FourKind extends HighCard
  name: -> "four_kind"

class FullHouse extends HighCard
  name: -> "full_house"

class Flush extends HighCard
  name: -> "flush"

class Straight extends HighCard
  name: -> "straight"

class ThreeKind extends HighCard
  name: -> "three_kind"

class TwoPair extends HighCard
  name: -> "two_pair"

class OnePair extends HighCard
  name: -> "one_pair"

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
    if this.isThreeKind()
      value = @value
      if this.isPair() || this.isDoper()
        @value = new FullHouse([value.rank, this.value.rank])
        return true
    false

  isThreeKind: ->
    for kind, cards of @kinds
      if cards.length == 3
        @value = new Set({kind: kind, cards: cards})
        return true
    false

  isTwoPair: ->
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

  isOnePair: ->
    for kind, cards of @kinds
      if cards.length == 2
        @value = new Pair({kind: kind, cards: cards})
        return true
    false

  isHighCard: ->
    @value = new HighCard(@cards)
    true

Hand.detect = (Cards)->
  hand = new Hand(Cards)
  while true
    break if hand.isStraightFlush()
    break if hand.isFourKind()
    break if hand.isFullHouse()
    break if hand.isFlush()
    break if hand.isStraight()
    break if hand.isThreeKind()
    break if hand.isTwoPair()
    break if hand.isOnePair()
    break if hand.isHighCard()
  return hand

exports.Hand = Hand

