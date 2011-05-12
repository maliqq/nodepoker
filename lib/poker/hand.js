var Doper, Flush, FullHouse, Hand, HighCard, Kind, LowCard, Pair, Quad, Rank, Set, Straight, StraightFlush, Suit;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
Kind = require(__dirname + '/kind').Kind;
Suit = require(__dirname + '/suit').Suit;
Rank = (function() {
  function Rank(data) {
    this.kind = data.kind;
    this.suit = data.suit;
    this.cards = data.cards;
    this.kickers = data.kickers;
  }
  Rank.prototype.toString = function() {
    return "[kind=" + this.kind + " suit=" + Suit.draw(this.suit) + " cards=" + this.cards.toString() + " kickers=" + this.kickers + "]";
  };
  return Rank;
})();
HighCard = (function() {
  function HighCard(data) {
    this.rank = data.cards != null ? new Rank(data) : data;
  }
  HighCard.prototype.name = function() {
    return "high_card";
  };
  HighCard.prototype.toString = function() {
    return this.name() + "::" + this.rank.toString();
  };
  return HighCard;
})();
StraightFlush = (function() {
  function StraightFlush() {
    StraightFlush.__super__.constructor.apply(this, arguments);
  }
  __extends(StraightFlush, HighCard);
  StraightFlush.prototype.name = function() {
    return "straight_flush";
  };
  return StraightFlush;
})();
Quad = (function() {
  function Quad() {
    Quad.__super__.constructor.apply(this, arguments);
  }
  __extends(Quad, HighCard);
  Quad.prototype.name = function() {
    return "quad";
  };
  return Quad;
})();
FullHouse = (function() {
  function FullHouse() {
    FullHouse.__super__.constructor.apply(this, arguments);
  }
  __extends(FullHouse, HighCard);
  FullHouse.prototype.name = function() {
    return "full_house";
  };
  return FullHouse;
})();
Flush = (function() {
  function Flush() {
    Flush.__super__.constructor.apply(this, arguments);
  }
  __extends(Flush, HighCard);
  Flush.prototype.name = function() {
    return "flush";
  };
  return Flush;
})();
Straight = (function() {
  function Straight() {
    Straight.__super__.constructor.apply(this, arguments);
  }
  __extends(Straight, HighCard);
  Straight.prototype.name = function() {
    return "straight";
  };
  return Straight;
})();
Set = (function() {
  function Set() {
    Set.__super__.constructor.apply(this, arguments);
  }
  __extends(Set, HighCard);
  Set.prototype.name = function() {
    return "set";
  };
  return Set;
})();
Doper = (function() {
  function Doper() {
    Doper.__super__.constructor.apply(this, arguments);
  }
  __extends(Doper, HighCard);
  Doper.prototype.name = function() {
    return "doper";
  };
  return Doper;
})();
Pair = (function() {
  function Pair() {
    Pair.__super__.constructor.apply(this, arguments);
  }
  __extends(Pair, HighCard);
  Pair.prototype.name = function() {
    return "pair";
  };
  return Pair;
})();
LowCard = (function() {
  function LowCard() {
    LowCard.__super__.constructor.apply(this, arguments);
  }
  __extends(LowCard, HighCard);
  LowCard.prototype.lo = function() {
    var card, kind, kinds, lo, _i, _len, _ref;
    kinds = (function() {
      var _i, _len, _ref, _results;
      _ref = this.rank;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        _results.push(card.kind);
      }
      return _results;
    }).call(this);
    lo = [];
    _ref = Kind.low;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      kind = _ref[_i];
      if (kinds.indexOf(kind) !== -1) {
        lo.push(kind);
      }
    }
    return lo;
  };
  LowCard.prototype.name = function() {
    return "lo";
  };
  LowCard.prototype.toString = function() {
    return this.name() + "::" + this.lo().toString();
  };
  return LowCard;
})();
Hand = (function() {
  function Hand(cards) {
    var card, kind, suit, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3;
    this.cards = cards;
    this.suits = {};
    this.kinds = {};
    _ref = Suit.all;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      suit = _ref[_i];
      this.suits[suit] = [];
    }
    _ref2 = Kind.all;
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      kind = _ref2[_j];
      this.kinds[kind] = [];
    }
    _ref3 = this.cards;
    for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
      card = _ref3[_k];
      this.kinds[card.kind].push(card);
      this.suits[card.suit].push(card);
    }
  }
  Hand.prototype.isStraightFlush = function() {
    var card, cards, suit, value, _i, _len;
    if (this.isStraight()) {
      value = this.value;
      cards = value.rank.cards;
      suit = null;
      for (_i = 0, _len = cards.length; _i < _len; _i++) {
        card = cards[_i];
        if (suit === null) {
          suit = card.suit;
        } else if (suit !== card.suit) {
          return false;
        }
      }
      if (suit != null) {
        this.value = new StraightFlush(this.value.rank);
        this.value.rank.suit = suit;
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isStraight = function() {
    var card, cards, i, kind, present, result, slice, _i, _j, _len, _len2, _ref, _ref2;
    for (i = 8, _ref = -1; 8 <= _ref ? i <= _ref : i >= _ref; 8 <= _ref ? i++ : i--) {
      slice = i === -1 ? ['A'].concat(Kind.all.slice(0, 4)) : Kind.all.slice(i, i + 5);
      result = true;
      cards = [];
      for (_i = 0, _len = slice.length; _i < _len; _i++) {
        kind = slice[_i];
        present = false;
        _ref2 = this.cards;
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          card = _ref2[_j];
          if (card.kind === kind) {
            cards.push(card);
            present = true;
          }
        }
        if (!present) {
          result = false;
          break;
        }
      }
      if (result) {
        kind = Kind.all[i + 5];
        this.value = new Straight({
          kind: kind,
          cards: cards
        });
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isFlush = function() {
    var cards, suit, _ref;
    _ref = this.suits;
    for (suit in _ref) {
      cards = _ref[suit];
      if (cards.length >= 5) {
        this.value = new Flush({
          suit: suit,
          cards: cards
        });
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isQuad = function() {
    var cards, kind, _ref;
    _ref = this.kinds;
    for (kind in _ref) {
      cards = _ref[kind];
      if (cards.length === 4) {
        this.value = new Quad({
          kind: kind,
          cards: cards
        });
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isFullHouse = function() {
    var value;
    if (this.isSet()) {
      value = this.value;
      if (this.isPair() || this.isDoper()) {
        this.value = new FullHouse([value.rank, this.value.rank]);
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isSet = function() {
    var cards, kind, _ref;
    _ref = this.kinds;
    for (kind in _ref) {
      cards = _ref[kind];
      if (cards.length === 3) {
        this.value = new Set({
          kind: kind,
          cards: cards
        });
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isDoper = function() {
    var cards, kind, total, v, value, _i, _len, _ref;
    total = 0;
    value = [];
    _ref = this.kinds;
    for (kind in _ref) {
      cards = _ref[kind];
      if (cards.length === 2) {
        value.push([kind, cards]);
        total++;
      }
    }
    if (total >= 2) {
      this.value = new Doper([]);
      for (_i = 0, _len = value.length; _i < _len; _i++) {
        v = value[_i];
        this.value.rank.push(new Rank({
          kind: v[0],
          cards: v[1]
        }));
      }
      return true;
    }
    return false;
  };
  Hand.prototype.isPair = function() {
    var cards, kind, _ref;
    _ref = this.kinds;
    for (kind in _ref) {
      cards = _ref[kind];
      if (cards.length === 2) {
        this.value = new Pair({
          kind: kind,
          cards: cards
        });
        return true;
      }
    }
    return false;
  };
  Hand.prototype.isHighCard = function() {
    this.value = new HighCard(this.cards);
    return true;
  };
  Hand.prototype.isLowCard = function() {
    this.value = new LowCard(this.cards);
    return true;
  };
  return Hand;
})();
Hand.detect = function(hand) {
  while (true) {
    if (hand.isStraightFlush()) {
      break;
    }
    if (hand.isQuad()) {
      break;
    }
    if (hand.isFullHouse()) {
      break;
    }
    if (hand.isFlush()) {
      break;
    }
    if (hand.isStraight()) {
      break;
    }
    if (hand.isSet()) {
      break;
    }
    if (hand.isDoper()) {
      break;
    }
    if (hand.isPair()) {
      break;
    }
    if (hand.isHighCard()) {
      break;
    }
  }
  return hand.value.name();
};
exports.Hand = Hand;