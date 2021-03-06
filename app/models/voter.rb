class Voter < ActiveRecord::Base
  attr_readonly :name_last, :name_first, :precinct, :street_no, :street_dir,
  							:street_name, :street_type, :apt, :apt_no, :city, :zip, :age
	
	named_scope :not_contacted, { :conditions => ["contacted IS NULL AND literature IS NULL"] }
	named_scope :lit, { :conditions => ["contacted IS NULL AND literature = 'x'"] }
	named_scope :candidate_contacted, { :conditions => ["contacted = 'x'"] }
	named_scope :volunteer_contacted, { :conditions => ["contacted = 'v'"] }
	named_scope :for_precinct, lambda { |pct| { :conditions => ["precinct = ?", pct] } }
	named_scope :default_order, { :order => 'street_name, street_no' }
	named_scope :yardsign, { :conditions => ['ys IS NOT NULL'] }
	
	acts_as_csv_exportable :default, [ :id, :name_last, :name_first, :street_no, :street_dir,
																		 :street_name, :street_type, :apt, :apt_no, :city, :zip,
																		 :precinct, :age, :phone, :text_message, :do_not_call,
																		 :contacted, :literature, :suf, :ys, :volunteer,
																		 :donations, :newreg, :notes ]
	
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
		self.find( :all, :select => 'DISTINCT precinct', :conditions=> ['precinct IS NOT NULL'] ).map { |p| p.precinct }
	end
	
	def self.progress( precinct )
		contacted = self.find( :all, :conditions => ["precinct = ? AND contacted IS NOT NULL", precinct] ).length
		total = self.find( :all, :conditions =>["precinct = ?", precinct] ).length
		return contacted.to_f / total * 100 
	end
	
	def self.progress_candidate( precinct )
		contacted = self.find( :all, :conditions => ["precinct = ? AND contacted = 'x'", precinct] ).length
		total = self.find( :all, :conditions =>["precinct = ?", precinct] ).length
		return contacted.to_f / total * 100 
	end
	
	def self.progress_volunteer( precinct )
		contacted = self.find( :all, :conditions => ["precinct = ? AND contacted = 'v'", precinct] ).length
		total = self.find( :all, :conditions =>["precinct = ?", precinct] ).length
		return contacted.to_f / total * 100 
	end
	
	def self.progress_literature( precinct )
		contacted = self.find( :all, :conditions => ["precinct = ? AND literature = 'x'", precinct] ).length
		total = self.find( :all, :conditions =>["precinct = ?", precinct] ).length
		return contacted.to_f / total * 100 
	end
	
	def self.progress_literature_only( precinct )
		contacted = self.find( :all, :conditions => ["precinct = ? AND literature = 'x' AND contacted IS NULL", precinct] ).length
		total = self.find( :all, :conditions =>["precinct = ?", precinct] ).length
		return contacted.to_f / total * 100 
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

