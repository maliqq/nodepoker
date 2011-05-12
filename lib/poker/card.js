var Card, Kind, Suit;
Kind = require(__dirname + '/kind').Kind;
Suit = require(__dirname + '/suit').Suit;
Card = (function() {
  function Card(kind, suit) {
    this.kind = kind;
    this.suit = suit;
  }
  Card.prototype.toString = function() {
    return this.kind + Suit.charOf(this.suit);
  };
  return Card;
})();
Card.from_string = function(s) {
  var a;
  a = s.split(/(?:)/);
  return new Card(a[0], a[1]);
};
Card.build_deck = function() {
  var cards, kind, suit, _i, _j, _len, _len2, _ref, _ref2;
  cards = [];
  _ref = Suit.all;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    suit = _ref[_i];
    _ref2 = Kind.all;
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      kind = _ref2[_j];
      cards.push(new Card(kind, suit));
    }
  }
  return cards;
};
Card.all = Card.build_deck();
Card.shuffle = function() {
  return Card.build_deck().sort(function() {
    return 0.5 - Math.random();
  });
};
Card.parse = function(s) {
  var c, cards, _i, _len, _ref;
  cards = [];
  _ref = s.match(/([AKQJT2-9]{1}[shdc]{1})/g);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    c = _ref[_i];
    cards.push(Card.from_string(c));
  }
  return cards;
};
exports.Card = Card;