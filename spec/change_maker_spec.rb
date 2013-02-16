# test for larger amounts

require "lib/change_maker.rb"

describe ChangeMaker do
  it "retuns two pennies when making change for 2" do
    ChangeMaker.greedily(2).should == [1, 1]
    ChangeMaker.dynamically(2).should == [1, 1]
  end

  it "greedily uses larger coins when possible" do
    ChangeMaker.greedily(27).should == [25, 1, 1]
    ChangeMaker.dynamically(27).should == [25, 1, 1]
  end

  it "smartly uses odd sized coins" do
    ChangeMaker.greedily(14, [10, 7, 1]).should == [10, 1, 1, 1, 1]
    ChangeMaker.dynamically(14, [10, 7, 1]).should == [7, 7]
  end

  it "doesn't miss a good opportunity to optimize" do
    ChangeMaker.greedily(14, [17, 11, 5, 4, 1]).should == [11, 1, 1, 1]
    ChangeMaker.dynamically(14, [17, 11, 5, 4, 1]).should == [5, 5, 4]
  end
end

