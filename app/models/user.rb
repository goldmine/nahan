# coding: utf-8


class User < ActiveRecord::Base
 
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password
  before_create { generate_token(:auth_token) }

  validates_presence_of :username, :message => "用户名忘了输啦！"
  validates_uniqueness_of :username, :email, :allow_blank => true, :message => "用户名已经被占用啦！"
  #TODO: username validate
  #validates_format_of :username，:with => /^[-\w\._]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "邮件格式不对！"
  validates_presence_of :password, :on => :create, :message => "密码忘了输啦！"
  validates_confirmation_of :password, :message => "密码两次输入的不一样！"
  validates_length_of :password, :minimum => 6, :allow_blank => true, :message => "密码至少要六位！"

  # login can be either username or email address
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

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end


end
