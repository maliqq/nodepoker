require 'spec_helper'

describe PokerNode::Hand do

  example 'detecting flush' do
    a = []
    PokerNode::SUIT.each { |suit|
      a << [suit] * 5
    }
    a.each { |suits|
      PokerNode::Hand.flush?(suits).should be_true
    }
  end

  example 'detecting straight' do
    
  end

  example 'detecting straight flush' do
    a = []
    0.upto(8) { |i|
      PokerNode::SUIT.each { |suit|
        a << PokerNode::KIND.slice(i, 5).collect { |kind|
          "#{kind}#{suit}"
        }.join
      }
    }
    a.each { |s|
      PokerNode::Hand.detect(s).should == :straight_flush
    }
  end

  example 'detecting four of a kind' do
    PokerNode::KIND.collect { |kind|
      s = ''
      4.times {
        s << "#{kind}#{PokerNode::Suit.random}"
      }; s
    }.each { |s|
      PokerNode::Hand.detect(s).should == :four_of_kind
    }
  end

  example 'detecting full house' do
    PokerNode::Hand.detect('K♠K♥J♦J♣J♣').should == :full_house
  end

  example 'detecting flush' do
    PokerNode::Hand.detect('K♠9♠J♠8♠2♠').should == :flush
  end

  example 'detecting straight' do
    PokerNode::Hand.detect('8♠9♥10♦J♣Q♣').should == :straight
  end

  example 'detecting straight' do
    PokerNode::Hand.detect('8♠9♥10♦J♣Q♣').should == :straight
  end
end
