# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
 	  Category.create([{ :name => '社会' }, { :name => '民生' }, { :name => '娱乐' }, { :name => '体育' }, { :name => '军事' }, { :name => '科技' }, { :name => '财经' }])
      Role.create(:name => 'Administrator')

      admin = User.create(:username => 'sysadmin',
                  :email => 'admin@51han.net',
                  :password => '123456',
                  :password_confirmation => '123456')
      
      admin.roles << Role.first
      admin.save

