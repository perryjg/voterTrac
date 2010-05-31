Factory.define :voter do |v|
	v.name_last   Faker::Name.last_name
	v.name_first  Faker::Name.first_name
	v.street_no   Faker::Address.street_address
	v.street_dir  %w(N S E W).rand
	v.street_name Faker::Address.street_name
	v.street_type Faker::Address.street_suffix
	v.city				Faker::Address.city
	v.zip					Faker::Address.zip_code
	v.precinct		%w(06 08 11 13 14 18 42 46 51 52 56 77).rand
end

Factory.define :voter_pct06, :parent => :voter do |v|
	v.precinct '06'
end

Factory.define :voter_pct08, :parent => :voter do |v|
	v.precinct '08'
end

Factory.define :voter_pct11, :parent => :voter do |v|
	v.precinct '11'
end

Factory.define :voter_pct13, :parent => :voter do |v|
	v.precinct '13'
end

