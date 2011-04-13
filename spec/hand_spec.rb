require 'spec_helper'

describe Hand do
  example 'flush' do

    Suit.all.each do |suit|
      hand = Hand.new(Rand('A%B%C%D%E%'.gsub('%', suit)))
      hand.flush?.should be_true
    end

  end

  example 'straight and wheel' do

    Kind.straights.each do |kinds|
      hand = Hand.new(Card('%ss%ss%sh%sd%sc' % kinds))
      hand.straight?.should be_true
    end

    hand = Hand.new(Card('%ss%ss%sh%sd%sc' % Kind.straights.last))
    hand.wheel_straight?.should be_true

  end

  example 'straight and royal flush' do

    hand = Hand.new(Card('%ss%ss%ss%ss%ss' % Kind.straights.last))
    hand.straight_flush?.should be_true
    hand.royal_flush?.should be_false

    hand = Hand.new(Card('%ss%ss%ss%ss%ss' % Kind.straights.first)) #royal
    hand.straight_flush?.should be_true
    hand.royal_flush?.should be_true
    
  end

  example 'four kinds' do

    hand = Hand.new(Rand('AsAsAsAhBh'))
    hand.four_of_kind?.should be_true

  end

  example 'three of kind' do

    hand = Hand.new(Rand('AsAsAsBhCh'))
    hand.three_of_kind?.should be_true
    hand.full_house?.should be_false
    hand.one_pair?.should be_false
    hand.two_pair?.should be_false

  end

  example 'full house' do

    hand = Hand.new(Rand('AsAsAsBhBh'))
    hand.three_of_kind?.should be_true
    hand.full_house?.should be_true
    hand.one_pair?.should be_true
    hand.two_pair?.should be_false

  end

  example 'two pairs' do

    hand = Hand.new(Rand('AsAsBsBhCh'))
    hand.three_of_kind?.should be_false
    hand.full_house?.should be_false
    hand.one_pair?.should be_true
    hand.two_pair?.should be_true

  end

  example 'one pair' do

    hand = Hand.new(Rand('AsAsBsChDh'))
    hand.three_of_kind?.should be_false
    hand.full_house?.should be_false
    hand.one_pair?.should be_true
    hand.two_pair?.should be_false

  end
end
