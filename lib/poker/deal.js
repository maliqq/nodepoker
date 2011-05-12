var Deal;
Deal = (function() {
  function Deal(size) {
    this.size = size;
    this.deck = new Deck();
  }
  return Deal;
})();