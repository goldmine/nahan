# coding: utf-8

class MessagesController < ApplicationController

  
  def show
    @message = current_user.received_messages.find(params[:id])
    @message.update_attribute("is_read",true)
  end
  
  def destroy
     @message = current_user.received_messages.find(params[:id])
     @message.update_attribute("deleted",true) 
     redirect_to mailbox_index_path
  end
  
   def undelete
     @message = current_user.received_messages.find(params[:id])
     @message.update_attribute("deleted",false) 
     redirect_to mailbox_index_path
  end
  
  def fdelete
     @message = current_user.received_messages.find(params[:id])
     @message.update_attribute("is_hide",true)
     flash[:notice] = "成功删除"     
     redirect_to :controller => "mailbox", :action =>"trash"
  end
  
  def reply
    @original = current_user.received_messages.find(params[:id])
    subject = @original.subject.sub(/^/,"Re:")
    body = @original.body.gsub(/^/,"> ")
    @message = current_user.sent_messages.build(:to => @original.author.username, :subject => subject, :body => body)
    render :template => "sent/new"
  end
  
  def forward
    @original = current_user.received_messages.find(params[:id])
    subject = @original.subject.sub(/^(FWD:)?/,"FWD:")
    body = @original.body.gsub(/^/,"> ")
    @message = current_user.sent_messages.build(:subject => subject, :body => body)
    render :template => "sent/new"
  end

  
  protected
  def allow_to
    super :user, :all => true
  end
  
end
