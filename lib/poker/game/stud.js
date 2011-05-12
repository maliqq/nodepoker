var Stud;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
Stud = (function() {
  function Stud() {
    Stud.__super__.constructor.apply(this, arguments);
  }
  __extends(Stud, Deal);
  Stud.prototype.deal = function() {
    var cards, i, j, _i, _len, _ref, _ref2, _results;
    this.hole_cards = [];
    for (i = 1, _ref = this.size; 1 <= _ref ? i <= _ref : i >= _ref; 1 <= _ref ? i++ : i--) {
      cards = [];
      for (j = 1; j <= 7; j++) {
        cards.push(this.deck.burn());
      }
      this.hole_cards.push(cards);
    }
    this.hands = [];
    _ref2 = this.hole_cards;
    _results = [];
    for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
      cards = _ref2[_i];
      _results.push(this.hands.push(new Hand(cards)));
    }
    return _results;
  };
  Stud.prototype.toString = function() {
    var hole, holes, i, _ref;
    holes = "";
    for (i = 0, _ref = this.size - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
      hole = this.hole_cards[i];
      Hand.detect(this.hands[i]);
      holes += "hole " + (i + 1) + ": " + hole.toString() + " | " + this.hands[i].value + "\n";
    }
    return holes;
  };
  return Stud;
})();