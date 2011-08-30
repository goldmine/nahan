class Folder < ActiveRecord::Base

  belongs_to :user
  has_many :messages, :class_name =>"MessageCopy"

end
