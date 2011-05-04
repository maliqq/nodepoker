class Deal
    constructor: (@size) ->
        deck = new Deck()
        @flop = []
        for i in [0..3]
            @flop.push deck.burn()
        @turn_card = deck.burn()
        @river_card = deck.burn()
        @hole_cards = []
        for i in [0..@size]
            @hole_cards.push [deck.burn(), deck.burn()]
        @hands = []
        for i in [0..@size]
            @hands.push new Hand(this.river().concat(@hole_cards[i]))
    turn: ->
        this.flop.concat [this.turn_card]
    river: ->
        this.turn().concat [this.river_card]
    toString: ->
        holes = ""
        for i in [0..@size]
            hole = @hole_cards[i]
            Hand.detect @hands[i]
            holes += "\thole " + (i + 1) + ": " + hole.toString() + " | " + @hands[i].value + "\n"
        "river: " + @river().toString() + "\n" + holes
