module PokerNode
  module Rand
    class << self
      # Random.generate('AAABB')
      def from_string(s)
        deck = Deck.new
        s.tap {
          used = {}
          s.squeeze.split(//).each do |letter|
            if letter == '*'
              card = deck.burn_random_kind!
            elsif letter =~ /[a-z]/i
              used[letter] ||= deck.burn_random_kind!
              card = used[letter]
            else
              next
            end
            s.gsub!(letter, card.kind)
          end
        }
      end

      alias :generate! from_string
    end
  end
end
