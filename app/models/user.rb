# coding: utf-8


class User < ActiveRecord::Base
 
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :age, :location, :gender, :education, :name, :desc, :avatar

  attr_accessor :password

  before_save :prepare_password
  before_create { generate_token(:auth_token) }
  
  has_many :roleuserships
  has_many :roles, :through => :roleuserships
  has_one :profile
  has_many :comments
  accepts_nested_attributes_for :profile, :allow_destroy => true
  
  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "48>", :tiny =>"15>" }

  # Message
  has_many :sent_messages,:class_name =>"Message", :foreign_key =>"author_id"
  has_many :received_messages,:class_name =>"MessageCopy", :foreign_key =>"recipient_id" 
  has_many :folders
  before_create :build_inbox


  # Friends
  has_many :friendships, :class_name  => "Friend", :foreign_key => 'inviter_id', :conditions => "status = #{Friend::ACCEPTED}"
  has_many :follower_friends, :class_name => "Friend", :foreign_key => "invited_id", :conditions => "status = #{Friend::PENDING}", :order => 'created_at DESC'
  has_many :following_friends, :class_name => "Friend", :foreign_key => "inviter_id", :conditions => "status = #{Friend::PENDING}", :order => 'created_at DESC'

  # has_many :friends,   :through => :friendships, :source => :invited
  has_many :fans, :through => :follower_friends, :source => :inviter
  has_many :followings, :through => :following_friends, :source => :invited




  validates_presence_of :username, :message => "用户名忘了输啦！"
  validates_uniqueness_of :username, :email, :allow_blank => true, :message => "用户名已经被占用啦！"
  #TODO: username validate
  #validates_format_of :username，:with => /^[-\w\._]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "邮件格式不对！"
  validates_presence_of :password, :on => :create, :message => "密码忘了输啦！"
  validates_confirmation_of :password, :message => "密码两次输入的不一样！"
  validates_length_of :password, :minimum => 6, :allow_blank => true, :message => "密码至少要六位！"

  # login ----------------------------------------------------------
  
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  
    end while User.exists?(column => self[column])  
  end 

  def send_password_reset  
    generate_token(:password_reset_token)  
    self.password_reset_sent_at = Time.zone.now  
    save!  
    UserMailer.password_reset(self).deliver  
  end 

  #Role --------------------------------------------------------

  def has_role?(role_name)
    self.roles.find_by_name(role_name) ? true : false
  end

  # Message-----------------------------------------------------
  def inbox
    folders.find_by_name("inbox")
  end


  def build_inbox
    folders.build(:name => "inbox")
  end

  # friends----------------------------------------------------

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end




end
