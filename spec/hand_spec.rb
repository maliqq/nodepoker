require 'spec_helper'

def random_suit(size = 1, limit = 3)
  s = []
  while s.size < size
    suit = PokerNode::SUIT[rand(PokerNode::SUIT.size)]
    s << suit if s.count(suit) < limit
  end; s
end

def random_kind(size = 1, limit = 1)
  s = []
  while s.size < size
    kind = PokerNode::KIND[rand(PokerNode::KIND.size)]
    s << kind if s.count(kind) < limit
  end; s
end

def kinds_with_each_suit(kinds, &block)
  PokerNode::SUIT.each { |suit|
    block.call(kinds.collect{ |kind| "#{kind}#{suit}" }.join)
  }
end

def kinds_with_random_suits(kinds)
  s = ''
  random_suit(5).each_with_index { |suit, i|
    s << "#{kinds[i]}#{suit}"
  }; s
end

def detect_hand(s)
  PokerNode::Hand.new(s).rank.to_sym
end

describe PokerNode::Hand do
  describe 'detecting' do
    example 'straight flush' do
      0.upto(8) { |i|
        kinds_with_each_suit(PokerNode::KIND.slice(i, 5)) { |h|
          detect_hand(h).should == :straight_flush
        }
      }
    end

    example 'four of a kind' do
      PokerNode::KIND.each { |a|
        h = kinds_with_random_suits([a, a, a, a])
        detect_hand(h).should == :four_of_kind
      }
    end

    example 'full house' do
      13.times {
        r = random_kind(2)
        a = r[0]
        b = r[1]
        h = kinds_with_random_suits([a, a, b, b, b])
        detect_hand(h).should == :full_house
      }
    end

    example 'flush' do
      kinds_with_each_suit(random_kind(5)) { |h|
        detect_hand(h).should == :flush
      }
    end

    example 'straight' do
      0.upto(8) { |i|
        kinds = PokerNode::KIND.slice(i, 5)
        h = kinds_with_random_suits(kinds)
        detect_hand(h).should == :straight
      }
    end

    example 'three of a kind' do
      13.times {
        r = random_kind(3)
        a = r.shift
        h = kinds_with_random_suits([a, a, a, *r])
        puts h unless detect_hand(h) == :three_of_kind
        detect_hand(h).should == :three_of_kind
      }
    end

    example 'two pairs' do
      13.times {
        r = random_kind(3)
        a = r.shift
        b = r.shift
        h = kinds_with_random_suits([a, a, b, b, *r])
        detect_hand(h).should  == :two_pair
      }
    end

    example 'one pair' do
      13.times {
        r = random_kind(5)
        a = r.shift
        h = kinds_with_random_suits([a, a, *r])
        detect_hand(h).should == :one_pair
      }
    end

    example 'high card' do
      #13.times {
      #  r = random_kind(5)
      #  h = kinds_with_random_suits(r)
      #  detect_hand(h).should == :high_card
      #}
    end
  end

  describe 'comparing' do
  end

  xit 'shuffle' do
    [:four_of_kind?, :straight_flush?].each { |m|
      retries = 0
      while true
        retries += 1
        table = PokerNode::Deal.new(5)
        table.shuffle
        break if table.winner_hand.send(m)
      end
      retries.should > 0
    }
  end
end
