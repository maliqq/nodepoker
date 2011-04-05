require 'spec_helper'

include PokerNode

describe Deal do
  example 'shuffle' do
    deal = Deal.new(5)
    deal.limit.should == 5
    deal.flop.should be_empty
    deal.turn_card.should be_nil
    deal.river_card.should be_nil

    deal.shuffle
    deal.river.size.should == 5
    deal.turn_card.should be_kind_of(Card)
    deal.river_card.should be_kind_of(Card)
    deal.holes.size.should == deal.limit
  end
end
