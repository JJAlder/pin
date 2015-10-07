class RelationshipsController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@sent_invites = Current_user.sent_invites.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 2)
  	@received_invites = Current_user.received_invites.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 2)
	end

	def create
    @invited_user = User.find(params[:relationship][:invited_id])

    @relationship = Current_user.sent_invites.build(invited_id: @invited_user.id)

    if @relationship.save
        flash[:success] = "Successfully invited"
        redirect_to @invited_user
    else
        flash[:danger] = "Unsuccessful"
        redirect_to
    end
  end
  def destroy
    @relationship = Relationship.find(params[:id])
    if @relationship.inviting_user == current_user
    	@relationship.destroy
    	flash[:success] = "Removed relationship"
    end
    redirect_to @relationship.invited_user
	end

	def index
		@sent_invites = current_user.sent_invites
    @received_invites = current_user.received_invites
	end
end
