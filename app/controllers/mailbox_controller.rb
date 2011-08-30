# coding: utf-8

class MailboxController < ApplicationController

  def index
    @folder = current_user.inbox
    @foldername = "收件箱"
    show
    render :action => "show"
  end
  
  def show
    @folder ||= current_user.folders.find(params[:id])
    @messages = @folder.messages.not_deleted.paginate(:per_page => "10", :page => params[:page], :include => :message, :order =>"messages.created_at DESC")  
  end
  
  def trash
    @folder = Struct.new(:name,:user_id).new("垃圾箱",current_user.id)
    @messages = current_user.received_messages.deleted.paginate(:per_page => "10", :page => params[:page], :include => :message, :order =>"messages.created_at DESC") 
    @foldername = "垃圾箱"    
    render :action => "show"
  end

  def sent
    @messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    @foldername = "发件箱"    
  end
  
  def newmail
    @folder = Struct.new(:name,:user_id).new("新邮件",current_user.id)
    @messages = current_user.received_messages.not_readed.not_deleted.paginate(:per_page => "10", :page => params[:page], :include => :message, :order =>"messages.created_at DESC") 
    @foldername = "未读邮件"    
    render :action => "show"
  end
  
  protected
  
  def allow_to
    super :user, :all => true
  end

end
