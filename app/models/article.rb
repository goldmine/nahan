# coding: utf-8
class Article < ActiveRecord::Base

	belongs_to :category
	has_many :comments
	has_many :photos, :dependent => :destroy
	accepts_nested_attributes_for :photos, :allow_destroy => true

end
