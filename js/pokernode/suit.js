Suit = function() {}

Suit.all = ['s', 'h', 'd', 'c']
Suit.draw = function(suit) {
    return {'s': '♠', 'h': '♥', 'd': '♦', 'c': '♣'}[suit]
}
