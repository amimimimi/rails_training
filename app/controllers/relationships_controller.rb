class RelationshipsController < ApplicationController

  # post /relationships(.:format)
  def create
    user = User.find(params[:following_id])
    current_user.follow(user)
    redirect_to request.referrer
  end

  # delete /relationships/:id(.:format)
  def destroy
    user = Relationship.find(params[:id]).following
    current_user.unfollow(user)
    redirect_to request.referrer
  end

end
