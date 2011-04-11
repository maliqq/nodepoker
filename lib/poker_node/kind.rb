module PokerNode
  class Kind
    KIND = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
    
    def self.all
      KIND
    end

    def self.size
      KIND.size
    end

    def self.index(kind)
      all.index(kind)
    end

    def self.straights
      @@straights ||= (3..12).to_a.reverse.collect { |i|
        if i == 3
          Kind.all.slice(0, 4).unshift('A') # wheel
        else
          Kind.all.slice(i - 4, 5)
        end
      }
    end
  end
end
