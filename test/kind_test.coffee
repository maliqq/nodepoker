vows = require 'vows'
assert = require 'assert'
util = require 'util'

Kind = require('../lib/poker/kind').Kind
suite = vows.describe 'Kind'

suite.addBatch {
  'base': {
    topic: (() -> Kind),
    'length': ((topic) ->
      assert.equal(topic.all.length, 13)
      assert.equal(topic.names.length, 13)
      
      assert.equal(topic.indexOf('A'), 12)
      assert.equal(topic.nameOf('A'), 'ace')
    )
  }
}

suite.export module


