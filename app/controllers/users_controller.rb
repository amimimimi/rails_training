class UsersController < ApplicationController

  # get /users/:id(.:format)
  def show
    @user = User.find(params[:id])
  end

  # get /users/:id/following(.:format)
  def following
    @user = User.find(params[:id])
  end

  # get /users/:id/followers(.:format)
  def followers
    @user = User.find(params[:id])
  end

end
