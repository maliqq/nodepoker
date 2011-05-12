var Deck;
Deck = (function() {
  function Deck() {
    this.cards = Card.shuffle();
  }
  Deck.prototype.burn = function() {
    return this.cards.shift();
  };
  return Deck;
})();