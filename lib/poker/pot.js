var Pot, SidePot, util, _;
_ = require('underscore')._;
util = require('util');
SidePot = (function() {
  function SidePot(amount, members) {
    this.amount = amount;
    this.members = members;
  }
  SidePot.prototype.update_counter = function(key, amount) {
    this.ensure_member(key);
    return this.members[key] += amount;
  };
  SidePot.prototype.rewrite_counter = function(key, amount) {
    return this.members[key] = amount;
  };
  SidePot.prototype.total = function() {
    var key, sum, value, _ref;
    sum = 0;
    _ref = this.members;
    for (key in _ref) {
      value = _ref[key];
      sum += value;
    }
    return sum;
  };
  SidePot.prototype.is_member = function(player) {
    return _.include(_.keys(this.members), player);
  };
  SidePot.prototype.add_member = function(player) {
    return this.members[player] = 0;
  };
  SidePot.prototype.ensure_member = function(player) {
    if (!this.is_member(player)) {
      return this.add_member(player);
    }
  };
  SidePot.prototype.add_bet = function(player, amount) {
    var all_in, bet, d, unallocated;
    this.ensure_member(player);
    bet = this.members[player];
    all_in = this.amount;
    unallocated = 0;
    if (all_in > 0) {
      d = all_in - bet;
      unallocated = amount;
      if (d > 0) {
        this.rewrite_counter(player, all_in);
        unallocated = amount - d;
      }
    } else {
      this.update_counter(player, amount);
    }
    return unallocated;
  };
  SidePot.prototype.inspect = function() {
    if (this.amount > 0) {
      return this.amount + "$ - " + util.inspect(this.members);
    } else {
      return util.inspect(this.members);
    }
  };
  return SidePot;
})();
Pot = (function() {
  function Pot() {
    this.current = new SidePot(0, []);
    this.active = [];
    this.inactive = [];
  }
  Pot.prototype.main_pot = function() {
    return this.active[0];
  };
  Pot.prototype.side_pots = function() {
    var pot, pots, _i, _len, _ref;
    pots = [this.current];
    _ref = this.active.concat(this.inactive);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      pot = _ref[_i];
      if (_.values(pot.members).length > 0 && pot.total() > 0) {
        pots.push(pot);
      }
    }
    return pots;
  };
  Pot.prototype.total = function() {
    var pot, sum, _i, _len, _ref;
    sum = 0;
    _ref = this.side_pots();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      pot = _ref[_i];
      sum += pot.total();
    }
    return sum;
  };
  Pot.prototype.add_bet = function(player, amount, is_all_in) {
    var unallocated;
    unallocated = this.allocate_bet(player, amount);
    if (is_all_in) {
      return this.split_pot(player, unallocated);
    } else {
      return this.current.add_bet(player, unallocated);
    }
  };
  Pot.prototype.remove_member = function(player) {};
  Pot.prototype.allocate_bet = function(player, amount) {
    var pot, u, _i, _len, _ref;
    u = amount;
    _ref = this.side_pots();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      pot = _ref[_i];
      u = pot.add_bet(player, u);
    }
    return u;
  };
  Pot.prototype.split_pot = function(player, amount) {
    var bet, list, list1, list2, members, members2, side_pot;
    side_pot = this.current;
    side_pot.update_counter(player, amount);
    members = side_pot.members;
    bet = members[player];
    list = _.keys(members);
    list1 = _.select(list, function(m) {
      return m !== player && members[m] > bet;
    });
    list2 = _.reduce(list1, (function(m, n) {
      m[n] = members[n] - bet;
      return m;
    }), {});
    this.current = new SidePot(0, list2);
    members2 = _.reduce(list, (function(m, n) {
      m[n] = members[n] > bet ? bet : members[n];
      return m;
    }), {});
    return this.active.push(new SidePot(bet, members2));
  };
  return Pot;
})();
exports.Pot = Pot;