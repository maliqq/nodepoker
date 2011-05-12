vows = require('vows')
assert = require('assert')
util = require('util')

Pot = require('../lib/poker/pot').Pot
suite = vows.describe('Pot')

suite.addBatch {
  'base': {
    topic: (() -> Pot),
    'example 1': ((topic) ->
      pot = new topic()
      pot.add_bet('A', 100)
      pot.add_bet('B', 60, true)
      console.log(util.inspect(pot))
      assert.equal pot.total(), 160
      assert.equal pot.active[0].total(), 120
      assert.equal pot.current.total(), 40
      assert.isTrue pot.current.is_member('A')
      assert.isFalse pot.current.is_member('B')
      assert.isTrue pot.active[0].is_member('A')
      assert.isTrue pot.active[0].is_member('B')
    ),
    'example 2': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 100
      pot.add_bet 'B', 60, true
      pot.add_bet 'C', 100
      console.log(util.inspect(pot))
      assert.equal pot.total(), 260
      assert.equal pot.active[0].total(), 180
      assert.equal pot.current.total(), 80
    ),
    'example 3': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 100
      pot.add_bet 'B', 60, true
      pot.add_bet 'C', 100
      pot.add_bet 'D', 500
      pot.add_bet 'A', 250, true
      pot.add_bet 'C', 400
      console.log(util.inspect(pot))
      assert.equal pot.total(), 1410
      assert.equal pot.active[0].total(), 240
      assert.equal pot.active[1].total(), 870
      assert.equal pot.current.total(), 300
    ),
    'example 4': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 50
      pot.add_bet 'B', 20, true
      pot.add_bet 'C', 30, true
      console.log(util.inspect(pot))
      assert.equal pot.total(), 100
      assert.equal pot.active[0].total(), 60
      assert.equal pot.current.total(), 20
    ),
    'example 5': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 10
      pot.add_bet 'B', 10
      pot.add_bet 'C', 7, true
      pot.add_bet 'D', 10
      console.log(util.inspect(pot))
      assert.equal pot.total(), 37
      assert.equal pot.active[0].total(), 28
      assert.equal pot.current.total(), 9
    ),
    'example 6': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 10
      pot.add_bet 'B', 10
      pot.add_bet 'C', 7, true
      pot.add_bet 'D', 20
      pot.add_bet 'A', 10
      pot.add_bet 'B', 20
      pot.add_bet 'D', 10
      pot.remove_member('A')
      console.log(util.inspect(pot))
      assert.equal pot.total(), 87
      assert.equal pot.active[0].total(), 28
      assert.equal pot.current.total(), 59
    ),
    'example 7': ((topic) ->
      pot = new topic()
      pot.add_bet 'A', 10
      pot.add_bet 'B', 10
      pot.add_bet 'C', 7, true
      pot.add_bet 'D', 20
      pot.add_bet 'A', 2, true
      pot.add_bet 'B', 20
      pot.add_bet 'D', 10
      console.log(util.inspect(pot))
      assert.equal pot.active[0].total(), 28
      assert.equal pot.active[1].total(), 15
      assert.equal pot.current.total(), 36
    )
  }
}

suite.export module

