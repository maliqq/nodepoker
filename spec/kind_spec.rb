require 'spec_helper'

describe Kind do
  example 'all kinds' do
    Kind.all.should == Kind::KIND
    Kind.all.size.should == Kind.size
    Kind.size.should == 13
  end
end
