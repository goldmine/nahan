class ProfilesController < ApplicationController
  prepend_before_filter :get_user

  def index
  end

  def show
  end

  def show_by_name
  	@user =  User.find_by_username(params[:username])
  	@profile = @user.profile
  	render :action => "show"
  end

  def edit
  end

  def update
  end

  protected

  def get_user
  	@user = User.find(params[:user_id]) if params[:user_id]
  	@profile = @user.profile if @user
  end

  def allow_to
  	super :admin, :all => true
  	super :user, :only => [:show_by_name, :show]
  	super :owner, :all => true
  end

end
