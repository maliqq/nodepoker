require 'spec_helper'

describe Omaha::Deal do

end

describe Omaha::Hole do
  example 'hole size' do
    Omaha::Hole.size.should == 4
  end
end
