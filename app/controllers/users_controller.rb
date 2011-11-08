# coding: utf-8

class UsersController < ApplicationController
  #before_filter :login_required, :except => [:new, :create]
  prepend_before_filter :get_user

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(params[:user])
    if simple_captcha_valid? & @user.save & user.update_attribute(:last_login_at, Time.now)
      cookies[:auth_token] = @user.auth_token
      #session[:user_id] = @user.id
      redirect_to root_url, :notice => "欢迎加入呐喊网，您已经登入！."
    else
      flash.now[:alert] = "验证码错误." if !simple_captcha_valid?
      render :action => 'new'
    end
  end

  def edit
    #@user = current_user
  end

  def avatar
  
  end

  def show
    @user =  User.find_by_id(params[:id])
    @followings = @user.followings.first(10)
  end

  def show_by_name
    @user =  User.find_by_username(params[:username])
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
      super :owner, :only => [:edit, :update, :avatar]
      super :all, :only => [:index, :show, :show_by_name, :new, :create]
  end


end
