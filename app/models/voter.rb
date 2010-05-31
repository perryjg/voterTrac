class Voter < ActiveRecord::Base
  attr_accessible :name_last, :name_first, :precinct, :street_no, :street_dir, :street_name, :street_type, :apt, :apt_no, :age, :phone
end
