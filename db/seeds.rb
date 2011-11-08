# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
 	  Category.create([{ :name => '社会' }, { :name => '民生' }, { :name => '娱乐' }, { :name => '体育' }, { :name => '军事' }, { :name => '科技' }, { :name => '财经' }, { :name => '国际' }])
      Role.create(:name => 'Administrator')

      admin = User.create(:username => 'sysadmin',
                  :email => 'admin@51han.net',
                  :password => '123456',
                  :password_confirmation => '123456',
                  :location => '上海',
                  :age => '青年',
                  :gender => '男',
                  :education => '大学')
      
      admin.roles << Role.first
      admin.save

      for i in 1..50 do 
      	user = User.create(:username => i.to_s + "user",
                  :email => i.to_s + "user@51han.net",
                  :password => "123456",
                  :password_confirmation => "123456",
                  :location => "上海",
                  :age => "青年",
                  :gender => "男",
                  :education => "大学")
        user.save
      end

      User.all.each do |f|
      	Friend.add_follower(User.last, f) unless f == User.last
      	Friend.add_follower(f, User.last) unless f == User.last
      end

      for i in 1..10 do
            article = Article.create( :title => "12省份去年公路收费1025亿 债务均超百亿",
            :desc => "本报讯 全国收费公路专项清理第一阶段摸底调查已于8月底结束，按照要求，各地摸底情况近期将对外公布。截至昨日，至少已有北京、上海、山东等12省份公布了收费公路摸底调查结果。根据调查结果，12省份收费公路累计债务余额7593.5亿元。收费公路去年收费额1025.7亿元。",
            :publisher => "新京报",
            :link => "http://epaper.bjnews.com.cn/html/2011-10/17/content_285043.htm?div=-1",
            :author => "新京报",           
            :category_id => (i > 8 ? i = 1 : i) )

            article.save
      end

  


