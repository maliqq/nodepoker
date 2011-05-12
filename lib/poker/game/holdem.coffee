class Holdem extends Deal
    deal: ->
        @flop = []
        for i in [1..3]
            @flop.push @deck.burn()
        @turn_card = @deck.burn()
        @river_card = @deck.burn()
        @hole_cards = []
        for i in [1..@size]
            @hole_cards.push [@deck.burn(), @deck.burn()]
        @hands = []
        for cards in @hole_cards
            @hands.push new Hand(this.river().concat(cards))
    turn: ->
        this.flop.concat [this.turn_card]
    river: ->
        this.turn().concat [this.river_card]
    toString: ->
        holes = ""
        for i in [0..@size-1]
            hole = @hole_cards[i]
            Hand.detect @hands[i]
            holes += "\thole " + (i + 1) + ": " + hole.toString() + " | " + @hands[i].value + "\n"
        "river: " + @river().toString() + "\n" + holes
