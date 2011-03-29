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

def kinds_with_random_suits(kinds)
  s = ''
  random_suit(5).each_with_index { |suit, i|
    s << "#{kinds[i]}#{suit}"
  }; s
end

def detect_hand(s)
  PokerNode::Hand.new(s).to_sym
end

describe PokerNode::Hand do

  example 'flush?' do
    PokerNode::SUIT.each { |suit|
      PokerNode::Hand.flush?([suit] * 5).should be_true
    }
  end

  example 'straight?' do
    0.upto(8) { |i|
      PokerNode::Hand.straight?(PokerNode::KIND.slice(i, 5)).should be_true
    }
  end

  describe 'detecting' do

    example 'straight flush' do
      0.upto(8) { |i|
        PokerNode::SUIT.each { |suit|
          s = PokerNode::KIND.slice(i, 5).collect { |kind| "#{kind}#{suit}" }.join
          detect_hand(s).should == :straight_flush
        }
      }
    end

    example 'four of a kind' do
      PokerNode::KIND.each { |a|
        detect_hand(kinds_with_random_suits([a, a, a, a])).should == :four_of_kind
      }
    end

    example 'full house' do
      13.times {
        r = random_kind(2)
        a = r[0]
        b = r[1]
        detect_hand(kinds_with_random_suits([a, a, b, b, b])).
          should == :full_house
      }
    end

    example 'flush' do
      PokerNode::SUIT.each { |suit|
        s = random_kind(5).collect { |kind| "#{kind}#{suit}" }.join
        detect_hand(s).should == :flush
      }
    end

    example 'straight' do
      0.upto(8) { |i|
        PokerNode::SUIT.each { |suit|
          kinds = PokerNode::KIND.slice(i, 5)
          detect_hand(kinds_with_random_suits(kinds)).should == :straight
        }
      }
    end

    example 'three of a kind' do
      13.times {
        r = random_kind(3)
        a = r.shift
        h = kinds_with_random_suits([a, a, a, *r])
        detect_hand(h).should == :tree_of_kind
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
        detect_hand(kinds_with_random_suits([a, a, *r])).should == :one_pair
      }
    end

    example 'high card' do
      13.times {
        r = random_kind(5)
        detect_hand(kinds_with_random_suits(r)).should == :high_card
      }
    end
  end

  describe 'comparing' do
  end
end
