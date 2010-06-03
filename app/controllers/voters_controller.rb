class VotersController < ApplicationController
  def index
    @voters = Voter.all
  end
  
  def show
    @voter = Voter.find(params[:id])
  end
  
  def edit
    @voter = Voter.find(params[:id])
  end
  
  def update
    @voter = Voter.find(params[:id])
    if @voter.update_attributes(params[:voter])
      flash[:notice] = "Successfully updated voter."
      redirect_to @voter
    else
      render :action => 'edit'
    end
  end
  
  def walklist
	  v = Voter
	  v = v.for_precinct( params[:precinct] ) unless params[:precinct].blank?
	  v = v.not_contacted if params[:contacted]
	  v = v.lit if params[:literature]
	  v = v.default_order
	  @voters = v.all
  	render :template => 'voters/index'
  end
end
