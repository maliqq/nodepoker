var Kind;
Kind = function() {};
Kind.names = ["deuce", 'trey', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'jack', 'queen', 'king', 'ace'];
Kind.all = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
Kind.indexOf = function(kind) {
  return Kind.all.indexOf(kind);
};
Kind.nameOf = function(kind) {
  return Kind.names[Kind.indexOf(kind)];
};
exports.Kind = Kind;