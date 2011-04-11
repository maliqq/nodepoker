require 'spec_helper'
require 'set'

describe Card do
  example 'all cards' do
    Card.all.should == Card::CARD
    Card.all.size.should == 52
  end

  example 'deck' do
    Card.all.each { |card|
      card.to_s.should == "#{card.kind}#{card.suit}"
    }
  end

  example 'comparing' do
    Card.all.max.kind.should == 'A'
    Card.all.min.kind.should == '2'
  end

  example 'shuffle' do
    Set.new(Card.shuffle).should == Set.new(Card.all)
  end
end
