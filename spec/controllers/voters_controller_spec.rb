require File.dirname(__FILE__) + '/../spec_helper'
 
describe VotersController do
  #fixtures :all
  before(:each) do
#  	@request.env['HTTP_AUTHORIZATION'] = 
#  		ActionController::HttpAuthentication::Basic.encode_credentials( 'admin', 'roxy911' )
		VotersController.any_instance.stubs(:authenticate).returns(true)
  	(1..3).each do
  		Factory(:voter)
  	end
  end
  integrate_views
  
  context "index action" do
		it "should render index template" do
		  get :index
		  response.should render_template(:index)
		end
  end
  it "show action should render show template" do
    get :show, :id => Voter.first
    response.should render_template(:show)
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Voter.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Voter.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Voter.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Voter.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Voter.first
    response.should redirect_to(voter_url(assigns[:voter]))
  end
  
  
end
