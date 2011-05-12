_ = require('underscore')._
util = require 'util'

class SidePot
  constructor: (@amount, @members) ->

  update_counter: (key, amount) ->
    @ensure_member(key)
    @members[key] += amount

  rewrite_counter: (key, amount) ->
    @members[key] = amount
 
  total: ->
    sum = 0
    for key, value of @members
      sum += value
    sum

  is_member: (player) ->
    _.include _.keys(@members), player

  add_member: (player) ->
    @members[player] = 0

  ensure_member: (player) ->
    @add_member(player) unless @is_member(player)

  add_bet: (player, amount) ->
    @ensure_member(player)
    bet = @members[player]
    all_in = @amount
    unallocated = 0
    if all_in > 0
      d = all_in - bet
      unallocated = amount
      if d > 0
        @rewrite_counter(player, all_in)
        unallocated = amount - d
    else
      @update_counter(player, amount)
    unallocated

  inspect: ->
    if @amount > 0
      @amount + "$ - " + util.inspect(@members)
    else
      util.inspect(@members)

class Pot
  constructor: ->
    @current = new SidePot(0, [])
    @active = []
    @inactive = []

  main_pot: () ->
    @active[0]

  side_pots:  ->
    pots = [@current]
    for pot in @active.concat(@inactive)
      pots.push pot if _.values(pot.members).length > 0 and pot.total() > 0
    pots

  total: ->
    sum = 0
    for pot in @side_pots()
      sum += pot.total()
    sum

  add_bet: (player, amount, is_all_in) ->
    unallocated = @allocate_bet(player, amount)
    if is_all_in
      @split_pot(player, unallocated)
    else
      @current.add_bet(player, unallocated)

  remove_member: (player) ->

  allocate_bet: (player, amount) ->
    u = amount
    for pot in @side_pots()
      u = pot.add_bet(player, u)
    u

  split_pot: (player, amount) ->
    side_pot = @current
    side_pot.update_counter(player, amount)
    members = side_pot.members
    bet = members[player]
    list = _.keys(members)
    list1 = _.select list, (m) -> m != player and members[m] > bet
    list2 = _.reduce list1, ((m, n) ->
      m[n] = members[n] - bet
      m
    ), {}
    @current = new SidePot(0, list2)
    members2 = _.reduce list, ((m, n) ->
      m[n] = if members[n] > bet
        bet
      else
        members[n]
      m
    ), {}
    @active.push new SidePot(bet, members2)

exports.Pot = Pot

