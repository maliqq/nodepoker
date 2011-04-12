require 'spec_helper'

describe Holdem do
  example 'dealing' do
    deal = Holdem::Deal.new(3)
  end

  example 'kickers' do
    deal = Holdem::Deal.new(2)
    deal.shuffle!

    puts deal.inspect

    hand1 = deal.holes.first
    puts hand1.rank.inspect
    hand2 = deal.holes.last
    puts hand2.rank.inspect
  end
end
