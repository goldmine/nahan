class MessageCopy < ActiveRecord::Base
  
  belongs_to :message
  belongs_to :recipient, :class_name =>"User"
  belongs_to :folder
  delegate :author,:created_at,:subject,:body, :recipient, :to => :message
  #scope_out :deleted
  #scope_out :not_deleted, :conditions => ["deleted IS NULL OR deleted =?", false]
  scope :deleted, where("deleted = ?", true)  
  scope :not_deleted, where("deleted IS NULL OR deleted =?", false) 
  scope :readed, where("is_read = ?", true) 
  scope :not_readed, where("is_read IS NULL OR is_read = ?", false) 

end
