require 'spec_helper'

describe Holdem do
  example 'dealing' do
    deal = Holdem::Deal.new(3)
    deal.shuffle!
  end
end

describe 'hands comparing' do
  describe 'high card' do

    example 'straight flush' do
      river = Card('KsQsJs10s5c')
      hole1 = Holdem::Hole.new(river, Card('As4c'))
      hole1.hand.should be_straight_flush
      hole2 = Holdem::Hole.new(river, Card('9s3c'))
      hole2.hand.should be_straight_flush
      hole1.rank.should > hole2.rank
      hole1.rank.should_not < hole2.rank
      hole1.rank.high_cards.max.kind.should == 'A'
      hole2.rank.high_cards.max.kind.should == 'K'
    end

    example 'straight' do
      river = Card('KdQsJh10s5c')
      hole1 = Holdem::Hole.new(river, Card('Ac10h'))
      hole1.hand.should be_straight
      hole2 = Holdem::Hole.new(river, Card('9d3c'))
      hole2.hand.should be_straight
      hole1.rank.should > hole2.rank
      hole1.rank.should_not < hole2.rank
      hole1.rank.high_cards.max.kind.should == 'A'
      hole2.rank.high_cards.max.kind.should == 'K'
    end

    example 'flush' do
      river = Card('7s3sJs7d5d')
      hole1 = Holdem::Hole.new(river, Card('As10s'))
      hole1.hand.should be_flush
      hole2 = Holdem::Hole.new(river, Card('Ks9s'))
      hole2.hand.should be_flush

      hole1.rank.should > hole2.rank
      hole1.rank.should_not < hole2.rank
      hole1.rank.high_cards.max.kind.should == 'A'
      hole2.rank.high_cards.max.kind.should == 'K'
    end

    example 'four of kind' do
      
    end

    example 'full house' do
      river = Card('2s2h4d4h')
      hole1 = Holdem::Hole.new(river, Card('4c10d'))
      hole1.hand.should be_full_house
      hole2 = Holdem::Hole.new(river, Card('2cJd'))
      hole2.hand.should be_full_house

      hole1.rank.should > hole2.rank
      hole1.rank.should_not < hole2.rank
      hole1.rank.high_cards.max.kind.should == '4'
      hole2.rank.high_cards.max.kind.should == '2'
    end

  end
end
