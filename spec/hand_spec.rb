require 'spec_helper'

def Card(s)
  Card.parse!(s)
end

def Rand(s)
  Card(Rand.generate!(s))
end

describe Hand do
  example 'flush' do

    Suit.all.each do |suit|
      hand = Hand.new(Rand('A%B%C%D%E%'.gsub('%', suit)))
      hand.flush?.should be_true
    end

  end

  example 'straight and wheel' do

    Kind.straights.each do |kinds|
      hand = Hand.new(Card('%s♠%s♠%s♥%s♦%s♣' % kinds))
      hand.straight?.should be_true
    end

    hand = Hand.new(Card('%s♠%s♠%s♥%s♦%s♣' % Kind.straights.last))
    hand.wheel_straight?.should be_true

  end

  example 'straight and royal flush' do

    hand = Hand.new(Card('%s♠%s♠%s♠%s♠%s♠' % Kind.straights.last))
    hand.straight_flush?.should be_true
    hand.royal_flush?.should be_false

    hand = Hand.new(Card('%s♠%s♠%s♠%s♠%s♠' % Kind.straights.first)) #royal
    hand.straight_flush?.should be_true
    hand.royal_flush?.should be_true
    
  end

  example 'four kinds' do

    hand = Hand.new(Rand('A♠A♠A♠A♥B♥'))
    hand.four_of_kind?.should be_true

  end

  example 'three of kind' do

    hand = Hand.new(Rand('A♠A♠A♠B♥C♥'))
    hand.three_of_kind?.should be_true
    hand.full_house?.should be_false
    hand.one_pair?.should be_false
    hand.two_pair?.should be_false

  end

  example 'full house' do

    hand = Hand.new(Rand('A♠A♠A♠B♥B♥'))
    hand.three_of_kind?.should be_true
    hand.full_house?.should be_true
    hand.one_pair?.should be_true
    hand.two_pair?.should be_false

  end

  example 'two pairs' do

    hand = Hand.new(Rand('A♠A♠B♠B♥C♥'))
    hand.three_of_kind?.should be_false
    hand.full_house?.should be_false
    hand.one_pair?.should be_true
    hand.two_pair?.should be_true

  end

  example 'one pair' do

    hand = Hand.new(Rand('A♠A♠B♠C♥D♥'))
    hand.three_of_kind?.should be_false
    hand.full_house?.should be_false
    hand.one_pair?.should be_true
    hand.two_pair?.should be_false

  end
end
