class Stud extends Deal
    deal: ->
        @hole_cards = []
        for i in [1..@size]
            cards = []
            for j in [1..7]
                cards.push @deck.burn()
            @hole_cards.push cards
        @hands = []
        for cards in @hole_cards
            @hands.push new Hand(cards)
    toString: ->
        holes = ""
        for i in [0..@size-1]
            hole = @hole_cards[i]
            Hand.detect @hands[i]
            holes += "hole " + (i + 1) + ": " + hole.toString() + " | " + @hands[i].value + "\n"
        holes
