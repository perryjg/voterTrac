require File.dirname(__FILE__) + '/../spec_helper'

describe Voter do
	describe 'voter controller authentication' do
		
		it "should not succeed without login" do
			visit voters_path
			response.should_not be_success
			response.status.should == '401 Unauthorized'
		end
		
		it "should succeed with login" do
			basic_auth( 'admin', 'roxy911' )
			visit voters_path
			response.should be_success
		end
	end
	
	describe 'walklist' do
		before(:each) do
			basic_auth( 'admin', 'roxy911' )
		end
		context 'filtered by precinct' do
			before(:each) do
				Factory.build( :voter_pct06, :name_first => 'Fred' ).save
				Factory.build( :voter_pct06, :name_first => 'Harry', :contacted => 'x' ).save
				Factory.build( :voter_pct08, :name_first => 'George' ).save
			
				visit voters_path
				fill_in "Precinct", :with => '06'
				click_button
			end
		
			it "should render template index" do
				response.should render_template( :index )
			end
		
			it "should include the include precinct 06 voter: 'Fred'" do
				response.should have_text( /Fred/ )
			end
		
			it "should not include precinct 08 voter: 'George'" do
				response.should_not have_text( /George/ )
			end
		end
		
		context "filtered by contacted" do
			before(:each) do
				Factory.build( :voter, :name_first => 'Fred' ).save
				Factory.build( :voter, :name_first => 'Harry', :contacted => 'x' ).save
				Factory.build( :voter, :name_first => 'George', :literature => 'x' ).save
				
				visit voters_path
				check 'contacted'
				click_button 
			end
			
			it "should include voter not contacted: Fred" do
				response.should have_text( /Fred/ )
			end
			
			it "should not include contacted voter: 'Harry'" do
				response.should_not  have_text( /Harry/ )
			end
			
			it "should not include voter with literature: 'George'" do
				response.should_not  have_text( /George/ )
			end
		end
		
		context "filtered by volunteer contacted" do
			before(:each) do
				Factory.build( :voter, :name_first => 'Fred' ).save
				Factory.build( :voter, :name_first => 'Harry', :contacted => 'v' ).save
				Factory.build( :voter, :name_first => 'George', :contacted => 'x' ).save
				
				visit voters_path
				check 'Volunteer contacted'
				click_button 
			end
			
			it "should include volunter-contacted voter" do
				response.should include_text( 'Harry' )
			end
			
			it "should not include not-contacted voter Fred" do
				response.should_not include_text( 'Fred' )
			end
			
			it "should not include candidate-contacted voter George" do
				response.should_not include_text( 'George' )
			end
		end
		
		context "filtered by literature" do
			before(:each) do
				Factory.build( :voter, :name_first => 'Fred' ).save
				Factory.build( :voter, :name_first => 'Harry', :literature => 'x' ).save
				
				visit voters_path
				check 'Literature only'
				click_button 
			end
			
			it "should include the text 'Harry'" do
				response.should have_text( /Harry/ )
			end
			
			it "should not include the text 'Fred'" do
				response.should_not  have_text( /Fred/ )
			end
		end
		
		context "to download csv" do
			before(:each) do
				visit voters_path
			end
			
			it "should not have download csv link if action is :index" do
				response.should_not have_tag( 'a', 'Download CSV' )
			end
			
			it "should have download csv link if action is :walklist" do
				click_button
				response.should have_tag( 'a', 'Download CSV' )
			end
			
			it "should include previous search params in download link href" do
				check 'contacted'
				click_button
				response.should have_tag( 'a[href="/walklist.csv?contacted=true&amp;precinct="]' )
			end
		end
	end
end
