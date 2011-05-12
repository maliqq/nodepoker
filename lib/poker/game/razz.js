var Razz;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
Razz = (function() {
  function Razz() {
    Razz.__super__.constructor.apply(this, arguments);
  }
  __extends(Razz, Stud);
  Razz.prototype.toString = function() {
    var hole, holes, i, _ref;
    holes = "";
    for (i = 0, _ref = this.size - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
      hole = this.hole_cards[i];
      this.hands[i].isLowCard();
      holes += "hole " + (i + 1) + ": " + hole.toString() + " | " + this.hands[i].value + "\n";
    }
    return holes;
  };
  return Razz;
})();