require File.dirname(__FILE__) + '/../spec_helper'

describe Voter do
  it "should have full_name" do
  	voter = Factory.build(:voter, :name_first => 'Joe', :name_last => 'Citizen' )
  	voter.full_name.should == 'Citizen, Joe'
  end

  it "should return 'NO FIRST NAME if name_first is NULL" do
  	voter = Factory.build(:voter, :name_first => nil, :name_last => 'Citizen' )
  	voter.full_name.should match /NO FIRST NAME/
  end

  it "should return 'NO LAST NAME if name_last is NULL" do
  	voter = Factory.build(:voter, :name_last => nil )
  	voter.full_name.should match /NO LAST NAME/
  end

  it "should have address" do
  	voter = Factory.build(
  		:voter,
  		:street_no => 123,
  		:street_dir => 'W',
  		:street_name => 'Main',
  		:street_type => 'St',
  		:apt => nil )
  	voter.address.should == '123 W Main St'
  end

  it "should return 'NO ADDRESS AVAILABLE' if street_name is nill" do
  	voter = Factory.build( :voter, :street_name => nil )
  	voter.address.should == 'NO ADDRESS AVAILABLE'
  end
  
  it "should not include apartment if apartment number field is NULL" do
  	voter = Factory.build( :voter, :apt => 'Apt', :apt_no => nil )
  	voter.address.should_not match /Apt/
  end

  it "should have address with apartment number" do
  	voter = Factory.build(
  		:voter,
  		:street_no => 123,
  		:street_dir => 'W',
  		:street_name => 'Main',
  		:street_type => 'St',
  		:apt => 'Apt',
  		:apt_no => '100' )
  	voter.address.should == '123 W Main St, Apt 100'
  end

  it "should list distinct precincts" do
  	(1..5).each do
  		Factory(:voter_pct06)
  		Factory(:voter_pct08)
  		Factory(:voter_pct11)
  		Factory(:voter_pct13)
  	end
  	
  	Voter.precincts.should == %w(06 08 11 13)
  end
end

# == Schema Information
#
# Table name: voters
#
#  id           :integer(4)      not null, primary key
#  name_last    :string(255)
#  name_first   :string(255)
#  email        :string(255)
#  street_no    :integer(4)
#  street_dir   :string(255)
#  street_name  :string(255)
#  street_type  :string(255)
#  apt          :string(255)
#  apt_no       :string(255)
#  city         :string(255)
#  zip          :string(255)
#  precinct     :string(2)
#  age          :integer(4)
#  phone        :string(255)
#  phone_tmp    :string(255)
#  text_message :string(255)
#  do_not_call  :string(255)
#  contacted    :string(255)
#  literature   :string(255)
#  suf          :string(255)
#  ys           :string(255)
#  volunteer    :string(255)
#  donations    :string(255)
#  newreg       :string(255)
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

