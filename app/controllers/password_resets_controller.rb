# coding: utf-8

class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  		if simple_captcha_valid? & user
  			user.send_password_reset   
  			redirect_to root_url, :notice => "密码重置的链接已经发送到您的邮箱！" 
  		else
  			flash.now[:alert] = "该用户不存在，请检查邮件地址是否正确！" 
        flash.now[:alert] = "验证码错误." if !simple_captcha_valid?
  			render 'new'
  		end	
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update  
  	@user = User.find_by_password_reset_token!(params[:id])  
  		if @user.password_reset_sent_at < 2.hours.ago  
   			 redirect_to new_password_reset_path, :alert => "密码重置的链接已经过期了！请重新申请。"  
  		elsif @user.update_attributes(params[:user])  
   			 redirect_to root_url, :notice => "密码重置成功！"  
 		else  
   		     render :edit  
  		end  
  end 

  protected

  def allow_to 
    super :all, :all=> true
  end

end
