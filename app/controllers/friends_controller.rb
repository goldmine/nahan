# coding: utf-8

class FriendsController < ApplicationController
	prepend_before_filter :get_user

  def create
    @invited = User.find(params[:user_id])
      #if Friend.make_friends(@me, @invited)
      if Friend.add_follower(@me, @invited)
        flash[:notice] = "Successfully created..."
        redirect_to user_friends_url(@me)
        else
        message = "Oops... That didn't work. Try again!"
        redirect_to user_friends_url(@me)
      end
  end
  
  
  def destroy
    @owner = User.find(params[:user_id])
    @target = User.find(params[:id])
    if Friend.find_by_inviter_id_and_invited_id( @owner.id, @target ).destroy
    #Friend.reset @inviter, @invited
      flash[:notice] = "Successfully deleted..."
    else
      flash[:notice] = "Can not delete...."
    end
    redirect_to user_friends_url(@me)
  end
  
  
  def index
    @fans = @user.fans if @user
    @followings = @user.followings if @user
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
