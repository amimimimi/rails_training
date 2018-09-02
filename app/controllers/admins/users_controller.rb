class Admins::UsersController < Admins::Base
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'deleted successfully'
    else
      flash[:alert] = 'failed to delete'
    end
    redirect_to admins_users_path
  end
end
