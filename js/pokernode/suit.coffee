Suit = ->
Suit.all = ['s', 'h', 'd', 'c']
Suit.draw = (suit) ->
    {'s': '♠', 'h': '♥', 'd': '♦', 'c': '♣'}[suit]

