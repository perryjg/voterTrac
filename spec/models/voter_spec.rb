require File.dirname(__FILE__) + '/../spec_helper'

describe Voter do
  it "should be valid" do
    Voter.new.should be_valid
  end
end
