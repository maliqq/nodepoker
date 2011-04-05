require 'spec_helper'

describe PokerNode::Card do
  example 'deck' do
    PokerNode::CARDS.each { |card|
      card.to_s.should == "#{card.kind}#{card.suit}"
    }
  end

  example 'comparing' do
    PokerNode::CARDS.max.kind.should == 'A'
    PokerNode::CARDS.min.kind.should == '2'
  end
end
