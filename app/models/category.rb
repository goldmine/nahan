# coding: utf-8

class Category < ActiveRecord::Base
	has_many :articles
end
