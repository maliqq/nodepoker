vows = require 'vows'
assert = require 'assert'
util = require 'util'
Card = require('../lib/poker/card').Card
_ = require('underscore')._
suite = vows.describe('Card')

suite.addBatch {
  'card': {
    topic: (() -> Card),
    'all': ((topic) ->
      assert.equal Card.all.length, 52
      assert.instanceOf Card.all[0], Card
      assert.instanceOf Card.build_deck()[0], Card
      assert.instanceOf Card.shuffle()[0], Card
    ),
    'new': ((topic) ->
      card = new topic('K', 's')
      assert.equal card.kind, 'K'
      assert.equal card.suit, 's'
      assert.equal card.toString(), 'K♠'
    ),
    'from string': ((topic) ->
      card = topic.from_string('Td')
      assert.equal card.kind, 'T'
      assert.equal card.suit, 'd'
    ),
    'shuffle': ((topic) ->
      to_s = (v) -> v.toString()
      assert.notDeepEqual _.map(topic.shuffle(), to_s), _.map(topic.shuffle(), to_s)
    ),
    'parse': ((topic) ->
      cards = Card.parse('QsKh')
      card = cards[0]
      assert.instanceOf cards, Array
      assert.equal card.kind, 'Q'
      assert.equal card.suit, 's'
    )
  }
}
suite.export module


