require File.dirname(__FILE__) + '/../spec_helper'
 
describe VotersController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
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
