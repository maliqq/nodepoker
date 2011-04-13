require 'spec_helper'

describe Omaha::Deal do

end

describe Omaha::Hole do
  example 'hole size' do
    Omaha::Hole.size.should == 4
  end

  example 'dealing' do

    deal = Omaha::Deal.new(2)
    deal.shuffle!

    puts deal.holes.first.rank.inspect
    puts deal.holes.last.rank.inspect

  end
end
