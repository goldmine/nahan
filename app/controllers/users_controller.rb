# coding: utf-8

class UsersController < ApplicationController
  #before_filter :login_required, :except => [:new, :create]
  prepend_before_filter :get_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      #session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    #@user = current_user
  end

  def update
    #@user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end


  protected

  def get_user
    @user = current_user
  end
  
  def allow_to
      super :admin, :all => true
      super :owner, :only => [:edit, :update]
      super :all, :only => [:index, :show, :show_by_name, :new, :create]
  end


end
