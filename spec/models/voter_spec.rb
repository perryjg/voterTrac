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
  
  it "should filter for voters not contacted" do
	  Voter.delete_all
  	contacted_voter = Factory.build( :voter, :contacted => 'x' )
  	contacted_voter.save
  	not_contacted_voter = Factory.build(:voter)
  	not_contacted_voter.save
  	
  	v = Voter.not_contacted
  	v.count.should == 1
  	v[0].should == not_contacted_voter
  end
  
  it "should filter by lit" do
  	Voter.delete_all
		no_lit = Factory.build(:voter)
		no_lit.save
		lit = Factory.build( :voter, :literature => 'x' )
		lit.save
  	
  	v = Voter.lit
  	v.count.should == 1
  	v[0].should == lit
  end

  it "should filter for contacted by candidate" do
	  Voter.delete_all
  	not_contacted = Factory.build( :voter )
  	not_contacted.save
  	volunteer_contacted = Factory.build(:voter, :contacted => 'v' )
  	volunteer_contacted.save
  	candidate_contacted = Factory.build( :voter, :contacted => 'x' )
  	candidate_contacted.save
  	
  	v = Voter.candidate_contacted
  	v.count.should == 1
  	v[0].should == candidate_contacted
  end

  it "should filter for contacted by volunteer" do
	  Voter.delete_all
  	not_contacted = Factory( :voter )
  	volunteer_contacted = Factory.build(:voter, :contacted => 'v' )
  	volunteer_contacted.save
  	candidate_contacted = Factory.build( :voter, :contacted => 'x' )
  	candidate_contacted.save
  	
  	v = Voter.volunteer_contacted
  	v.count.should == 1
  	v[0].should == volunteer_contacted
  end
  
  it "should filter by precinct" do
  	Voter.delete_all
  	Factory( :voter_pct06 )
  	Factory( :voter_pct08 )
  	pct11_voter = Factory( :voter_pct11 )
  	
  	v = Voter.for_precinct( '11' )
  	v.count.should == 1
  	v[0].should == pct11_voter
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

