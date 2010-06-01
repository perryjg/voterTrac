class Voter < ActiveRecord::Base
  attr_readonly :name_last, :name_first, :precinct, :street_no, :street_dir,
  							:street_name, :street_type, :apt, :apt_no, :city, :zip, :age
	
	named_scope :not_contacted, { :conditions => ["contacted IS NULL"] }
	named_scope :lit, { :conditions => ["literature = 'x'"] }
	named_scope :candidate_contacted, { :conditions => ["contacted = 'x'"] }
	named_scope :volunteer_contacted, { :conditions => ["contacted = 'v'"] }
	named_scope :for_precinct, lambda { |pct| { :conditions => ["precinct = ?", pct] } }
	named_scope :default_order, { :order => 'street_name, street_no' }
	
	def full_name
		self.name_last = 'NO LAST NAME' if self.name_last.nil?
		self.name_first = 'NO FIRST NAME' if self.name_first.nil?
		self.name_last + ', ' + self.name_first
	end
	
	def address
		return 'NO ADDRESS AVAILABLE' if self.street_name.nil?
		
		address = [ self.street_no, self.street_dir, self.street_name, self.street_type ].join( ' ' )
		return address if ( self.apt.nil? || self.apt_no.nil? )
		
		address + ', ' + self.apt + ' ' + self.apt_no
	end
	
	def self.precincts
		Voter.find( :all, :select => 'DISTINCT precinct', :conditions=> ['precinct IS NOT NULL'] ).map { |p| p.precinct }
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

