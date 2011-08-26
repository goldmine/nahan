class Role < ActiveRecord::Base
	
	has_many :roleuserships
	has_many :users, :through => :roleuserships

		
end
