class WalklistController < ApplicationController
  def index
	  v = Voter
	  v = v.for_precinct( params[:precinct] ) unless params[:precinct].blank?
	  v = v.not_contacted if params[:contacted]
	  v = v.volunteer_contacted if params[:volunteer]
	  v = v.lit if params[:literature]
	  v = v.yardsign if params[:yardsign]
	  v = v.default_order
	  
	  @voters = v.all
	  
	  respond_to do |wants|
  		wants.html # index.html.erb
  		wants.csv  { render :text => @voters.to_csv }
  	end
  end
end
