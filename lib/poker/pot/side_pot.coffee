class SidePot
  constructor: -> (@player, @amount)
    @members = [@player.id]
  add_member: (player) ->
    @members.push player.id

exports.SidePot = SidePot

