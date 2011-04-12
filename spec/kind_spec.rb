require 'spec_helper'

describe Kind do
  example 'all kinds' do
    Kind.all.should == Kind::KIND
    Kind.all.size.should == Kind.size
    Kind.size.should == 13
  end

  example 'straight slice' do
    Kind.straight_slice(5).should == ['3', '4', '5', '6', '7']
  end

  example 'straight to kind' do
    Kind.straight_to('K').should == ['9', '10', 'J', 'Q', 'K']
  end

  example 'wheel straight' do
    Kind.wheel_straight.should == ['A', '2', '3', '4', '5']
  end
end
