# coding: utf-8

class SentController < ApplicationController

  def show
    @message = current_user.sent_messages.find(params[:id])
  end

  def new
    @message = current_user.sent_messages.build(params[:message])
    @message.to = User.find(params[:id]).username if params[:id]
  end
  
  def create
    @user =User.find_by_username(params[:message][:to])
    puts @user.inspect
    if @user == nil or @user == current_user
      flash[:error] ="不能发送至本人或非本站用户！请检查收件人地址！"
      render :action =>"new"
    else
    subject = params[:message][:subject]
    body = params[:message][:body]
    @message = current_user.sent_messages.build(:subject =>subject, :body => body, :to=> @user.id)
      if @message.save
       flash[:notice] ="发送成功！"
       redirect_to mailbox_index_path
      else
       render :action =>"new"
      end
    end
  end
  
 def fdelete
     @message = current_user.sent_messages.find(params[:id])
     @message.update_attribute("is_hide",true)
     flash[:notice] = "成功删除"     
     redirect_to mailbox_index_path
 end

 protected
 
 def allow_to
  super :user, :all => true
 end    

end
