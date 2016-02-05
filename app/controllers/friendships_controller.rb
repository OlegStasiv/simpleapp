class FriendshipsController < ApplicationController

  def index
    redirect_to users_path
  end
  def show
    redirect_to users_path
  end
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to users_path
    end
    end


  def destroy
    @friendship = current_user.friendships.find_by(params[:id])||current_user.inverse_friendships.find_by(params[:id])

    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

end
