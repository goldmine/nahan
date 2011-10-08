# coding: utf-8

class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?, :login_required, :redirect_to_target_or_default, :store_target_location
	before_filter :allow_to, :current_user, :check_permissions


  protect_from_forgery
	
 #Login method---------------------------------------

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

  #private

  def store_target_location
    session[:return_to] = request.url
  end

  #Role method---------------------------------------

  def allow_to level = nil, args = {}
    return unless level
    @level ||= []
    @level << [level, args]    
  end
  
  def check_permissions
    logger.debug "IN check_permissions :: @level => #{@level.inspect} @current_user => #{@current_user.inspect}"
    return failed_check_permissions if @current_user && !@current_user.enabled
    return true if @current_user && @current_user.has_role?("Administrator")
    raise '@level is blank. Did you override the allow_to method in your controller?' if @level.blank?
    @level.each do |l|
      next unless (l[0] == :all) || 
        (l[0] == :non_user && !@current_user) ||
        (l[0] == :user && @current_user) ||
        (l[0] == :owner && @current_user && @user && @current_user == @user)
      args = l[1]
      @level = [] and return true if args[:all] == true
      
      if args.has_key? :only
        actions = [args[:only]].flatten
        actions.each{ |a| @level = [] and return true if a.to_s == action_name}
      end
    end
    return failed_check_permissions
  end
  
  def failed_check_permissions
    if RAILS_ENV != 'development'
      flash[:error] = 'It looks like you don\'t have permission to view that page.'
      redirect_back_or_default index_url and return true
    else
      render :text=><<-EOS
      <h1>It looks like you don't have permission to view this page.</h1>
      <div>
        login_user: #{@current_user.inspect}
        @user: #{@user.inspect}
        Permissions: #{@level.inspect}<br />
        Controller: #{controller_name}<br />
        Action: #{action_name}<br />
        Params: #{params.inspect}<br />
        Session: #{session.instance_variable_get("@data").inspect}<br/>
      </div>
      EOS
    end
    @level = []
    false
  end



  # #设置字符集
  # def set_charset
  #   @headers["Content-Type"] = "text/html; charset=utf8"
  #   @response.headers["Content-Type"] = "text/html; charset=utf8"
  #   suppress(ActiveRecord::StatementInvalid) do
  #     ActiveRecord::Base.connection.execute 'SET NAMES utf8'
  #   end
  # end

end
