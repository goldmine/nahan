class Friend < ActiveRecord::Base
  
  belongs_to :inviter, :class_name => 'User'
  belongs_to :invited, :class_name => 'User'
  #after_create :create_feed_item
  #after_update :create_feed_item

  # attr_immutable :id, :invited_id, :inviter_id
  
  # Statuses Array
  
  ACCEPTED = 1
  PENDING = 0
  #FOLLOWING = 2
  
  
  def validate
    errors.add('inviter', 'inviter and invited can not be the same user') if invited == inviter
  end
  
  def description user, target = nil
    return 'friend' if status == ACCEPTED
    return 'follower' if user == inviter
    'fan'
  end
  
  def create_feed_item
    feed_item = FeedItem.create(:item => self)
    inviter.feed_items << feed_item
    invited.feed_items << feed_item
  end
  # 
  # def after_create
  #   AccountMailer.deliver_follow inviter, invited, description(inviter)
  # end
  
  
  class << self
    

    def add_follower(inviter, invited)
      a = Friend.create(:inviter => inviter, :invited => invited, :status => PENDING)
#      logger.debug a.errors.inspect.blue
      !a.new_record?
    end
  
  
    def make_friends(owner, target)
      transaction do
        begin
          Friend.find(:first, :conditions => {:inviter_id => owner.id, :invited_id => target.id, :status => PENDING}).update_attribute(:status, ACCEPTED)
          Friend.create!(:inviter_id => target.id, :invited_id => owner.id, :status => ACCEPTED)
        rescue Exception
          return make_friends( target, owner) if owner.followed_by? target
          return add_follower(owner, target)
        end
      end
      true
    end
    
  
    def stop_being_friends(owner, target)
    transaction do
      begin
        Friend.find(:first, :conditions => {:inviter_id => target.id, :invited_id => owner.id, :status => ACCEPTED}).update_attribute(:status, PENDING)
          f = Friend.find(:first, :conditions => {:inviter_id => owner.id, :invited_id => target.id, :status => ACCEPTED}).destroy
        rescue Exception
          return false
        end
      end
      true
    end
    
    
    def reset(owner, target)
      #don't need a transaction here. if either fail, that's ok
      begin
        Friend.find(:first, :conditions => {:inviter_id => owner.id, :invited_id => target.id}).destroy
        Friend.find(:first, :conditions => {:inviter_id => target.id, :invited_id => owner.id, :status => ACCEPTED}).update_attribute(:status, PENDING)
      rescue Exception
        return true # we need something here for test coverage
      end
      true
    end
  
  
  end
end
