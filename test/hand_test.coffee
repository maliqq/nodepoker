vows = require 'vows'
assert = require 'assert'
util = require 'util'

Hand = require('../lib/poker/hand').Hand
Card = require('../lib/poker/card').Card

suite = vows.describe 'Hand'
suite.addBatch {
  'hands': {
    topic: (()-> Hand),
    'straight flush': ((topic) ->
      cards = Card.parse('QsAsTsKsJs')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'straight_flush')
      assert.equal(hand.isStraight(), true)
      assert.equal(hand.isFlush(), true)
      assert.equal(hand.isStraightFlush(), true)
    ),
    'flush': ((topic) ->
      cards = Card.parse('2d5d7d9dTd')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'flush')
      assert.equal(hand.isFlush(), true)
    ),
    'straight': ((topic) ->
      cards = Card.parse('QdJsTc8c9h')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'straight')
      assert.equal(hand.isStraight(), true)
    ),
    'quad': ((topic) ->
      cards = Card.parse('TsTcThTd5s')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'quad')
      assert.equal(hand.isQuad(), true)
    ),
    'full house': ((topic) ->
      cards = Card.parse('QhQcQd5s5d')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'full_house')
      assert.equal(hand.isSet(), true)
      assert.equal(hand.isPair(), true)
      assert.equal(hand.isFullHouse(), true)
    ),
    'set': ((topic) ->
      cards = Card.parse('7s7d7c5d9h')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'set')
      assert.equal(hand.isSet(), true)
    ),
    'doper': ((topic) ->
      cards = Card.parse('7d7c2c2d6h')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'doper')
      assert.equal(hand.isPair(), true)
      assert.equal(hand.isDoper(), true)
    ),
    'pair': ((topic) ->
      cards = Card.parse('JsJdQcKc2s')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'pair')
      assert.equal(hand.isPair(), true)
    ),
    'high card': ((topic) ->
      cards = Card.parse('2s4c6d7cTh')
      hand = new topic(cards)
      assert.equal(topic.detect(hand), 'high_card')
      assert.equal(hand.isHighCard(), true)
    )
  }
}

suite.export module


