# coding: utf-8

class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?, :login_required, :redirect_to_target_or_default, :store_target_location
	protect_from_forgery
	

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to login_url, :alert => "必须登录后才能访问该页面！."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

  private

  def store_target_location
    session[:return_to] = request.url
  end
end
