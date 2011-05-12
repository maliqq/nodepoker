var Holdem;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
Holdem = (function() {
  function Holdem() {
    Holdem.__super__.constructor.apply(this, arguments);
  }
  __extends(Holdem, Deal);
  Holdem.prototype.deal = function() {
    var cards, i, _i, _len, _ref, _ref2, _results;
    this.flop = [];
    for (i = 1; i <= 3; i++) {
      this.flop.push(this.deck.burn());
    }
    this.turn_card = this.deck.burn();
    this.river_card = this.deck.burn();
    this.hole_cards = [];
    for (i = 1, _ref = this.size; 1 <= _ref ? i <= _ref : i >= _ref; 1 <= _ref ? i++ : i--) {
      this.hole_cards.push([this.deck.burn(), this.deck.burn()]);
    }
    this.hands = [];
    _ref2 = this.hole_cards;
    _results = [];
    for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
      cards = _ref2[_i];
      _results.push(this.hands.push(new Hand(this.river().concat(cards))));
    }
    return _results;
  };
  Holdem.prototype.turn = function() {
    return this.flop.concat([this.turn_card]);
  };
  Holdem.prototype.river = function() {
    return this.turn().concat([this.river_card]);
  };
  Holdem.prototype.toString = function() {
    var hole, holes, i, _ref;
    holes = "";
    for (i = 0, _ref = this.size - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
      hole = this.hole_cards[i];
      Hand.detect(this.hands[i]);
      holes += "\thole " + (i + 1) + ": " + hole.toString() + " | " + this.hands[i].value + "\n";
    }
    return "river: " + this.river().toString() + "\n" + holes;
  };
  return Holdem;
})();