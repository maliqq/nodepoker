Kind = ->
Kind.names = ["deuce", 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'jack', 'queen', 'king', 'ace']
Kind.all = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

Kind.indexOf = (kind) ->
  Kind.all.indexOf(kind)

Kind.nameOf = (kind) ->
  Kind.names[Kind.indexOf(kind)]

exports.Kind = Kind
