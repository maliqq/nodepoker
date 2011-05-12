var Suit;
Suit = function() {};
Suit.all = ['s', 'h', 'd', 'c'];
Suit.chars = ['♠', '♥', '♦', '♣'];
Suit.names = ['spades', 'hearts', 'diamonds', 'clubs'];
Suit.entities = ['&spades;', '&hearts;', '&diams;', '&clubs;'];
Suit.indexOf = function(suit) {
  return Suit.all.indexOf(suit);
};
Suit.charOf = function(suit) {
  return Suit.chars[Suit.indexOf(suit)];
};
Suit.nameOf = function(suit) {
  return Suit.names[Suit.indexOf(suit)];
};
Suit.entityOf = function(suit) {
  return Suit.entities[Suit.indexOf(suit)];
};
exports.Suit = Suit;