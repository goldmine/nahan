class FriendsController < ApplicationController
	prepend_before_filter :get_user

  def create
    @invited = User.find(params[:user_id])
      if Friend.make_friends(@me, @invited)
        flash[:notice] = "Successfully created..."
        redirect_to user_friends_url(@me)
        else
        message = "Oops... That didn't work. Try again!"
        redirect_to user_friends_url(@me)
      end
  end
  
  
  def destroy
    @inviter = User.find(params[:user_id])
    @invited = User.find(params[:id])
    Friend.reset @inviter, @invited
    flash[:notice] = "Successfully deleted..."
    redirect_to user_friends_url(@me)
  end
  
  
  def index
  end

protected
  def allow_to
    super :user, :all => true
    super :non_user, :only => :index
  end
  
  def get_user
    @me = current_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end

end
