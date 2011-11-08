# coding: utf-8

class Message < ActiveRecord::Base

  belongs_to :author, :class_name =>"User"
  has_one :message_copy
  has_one :recipient, :through => :message_copy
  before_create :prepare_copies
  
  attr_accessor :to
  attr_accessible :subject,:body,:to
  validates_presence_of :subject, :message => "用户名忘了输啦！"
  
  def prepare_copies
    return if to.blank?
    # if to.type == "Array"
    #    to.each do |recipient|
    #     recipient = User.find(recipient)
    #     message_copies.build(:recipient_id => recipient.id, :folder_id => recipient.inbox.id)
    #    end
    #else
        recipient = User.find(to)
        self.build_message_copy(:recipient_id => recipient.id, :folder_id => recipient.inbox.id)
    #end
  end

end
