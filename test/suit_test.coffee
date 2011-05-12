vows = require('vows')
assert = require('assert')
util = require('util')

Suit = require('../lib/poker/suit').Suit
suite = vows.describe('Suit')
suite.addBatch({
  'base': {
    topic: (() -> Suit),
    'length': ((topic) ->
      assert.equal(topic.all.length, 4)
      assert.equal(topic.names.length, 4)
      assert.equal(topic.entities.length, 4) 
      assert.equal(topic.chars.length, 4)
      
      assert.equal(topic.indexOf('h'), 1)
      assert.equal(topic.charOf('h'), '♥')
      assert.equal(topic.nameOf('h'), 'hearts')
      assert.equal(topic.entityOf('h'), '&hearts;')
    )
  }
})
suite.export module


