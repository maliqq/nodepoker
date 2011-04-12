require 'spec_helper'

describe Deck do

  before :each do
    @deck = Deck.new
  end

  example 'burn' do

    @deck.burn!.should be_kind_of(Card)
    @deck.burn_random!.should be_kind_of(Card)
    @deck.burn_random_kind!.should be_kind_of(Card)

  end

  example 'size' do
    10.times { @deck.burn! }
    @deck.size.should == Card.size - 10
  end
end
