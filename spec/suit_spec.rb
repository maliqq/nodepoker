require 'spec_helper'

describe Suit do
  example 'all suits' do
    Suit.all.should == Suit::SUIT
    Suit.all.size.should == 4
  end
end
