# coding: utf-8
class Comment < ActiveRecord::Base
	has_ancestry
	belongs_to :user
	belongs_to :article, :counter_cache => true


	validates_presence_of :body, :message => "内容忘了输啦！"
end
