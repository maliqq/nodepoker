module PokerNode
  class Kind
    KIND = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze

    class << self
      def all
        KIND
      end

      def size
        KIND.size
      end

      def index(kind)
        all.index(kind)
      end

      def straight_slice(i)
        Kind.all.slice(i - 4, 5)
      end

      def straight_to(kind)
        straight_slice(index(kind))
      end

      def wheel_straight
        Kind.all.slice(0, 4).unshift('A')
      end

      def straights
        @@straights ||= begin
          slices = []
          12.downto(4) { |i|
            slices << straight_slice(i)
          }
          slices.push(wheel_straight)
        end
      end
    end
  end
end
