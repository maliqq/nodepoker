class Razz extends Stud
    toString: ->
        holes = ""
        for i in [0..@size-1]
            hole = @hole_cards[i]
            @hands[i].isLowCard()
            holes += "hole " + (i + 1) + ": " + hole.toString() + " | " + @hands[i].value + "\n"
        holes
