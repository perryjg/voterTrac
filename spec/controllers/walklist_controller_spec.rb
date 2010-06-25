require 'spec_helper'

describe WalklistController do
  integrate_views

  #Delete these examples and add some real ones
  it "should use WalklistController" do
    controller.should be_an_instance_of(WalklistController)
  end


  describe "GET 'index'" do
  	before( :each ) do
  		WalklistController.any_instance.stubs(:authenticate).returns(true)
			Factory(:voter_pct06)
  		get :index, { :precinct => '06' }
  	end
  	
    it "should be successful" do
      response.should be_success
    end
		
		it "index action should render index template" do
		  get :index
		  response.should render_template(:index)
		end
	  
	  it "should assign @voters" do
	  	assigns[:walklist].should == @voters
	  end
  	
  	it "should render index template" do
	  	response.should render_template(:index)
	  end
	  
	  it "should have precinct # in text" do
	  	response.should have_text( /06/ )
	  end
  end
  
  it "should return csv format" do
  	get :index, { :format => 'csv' }
  	response.header['Content-Type'].should match /text/
  end
end
