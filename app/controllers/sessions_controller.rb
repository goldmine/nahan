# coding: utf-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user && user.update_attribute(:last_login_at, Time.now)
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      #session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => "登录成功！"
    else
      flash.now[:alert] = "用户名密码错！"
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    #session[:user_id] = nil
    redirect_to root_url, :notice => "成功登出！"
  end


  private
  
  def allow_to 
    super :all, :all=> true
  end

end
