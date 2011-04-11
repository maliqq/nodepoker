require 'spec_helper'

describe Rand do
  it 'generate' do
    Rand.generate!('AAAAB')
    Rand.generate!('AAABB')
    Rand.generate!('AAACC')
    Rand.generate!('AABBC')
    Rand.generate!('X♠X♠X♠X♠X♠')
    Rand.generate!('z♠z♠z♠')
  end
end
