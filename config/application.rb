# coding: utf-8

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Nahan
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :haml
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'  
    #config.active_record.default_timezone = :Beijing
    config.active_record.default_timezone = :local 

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # My configure
    config.nahan_cities = ["安徽省", "澳门", "北京市", "福建省", "甘肃省", "广东省", "广西省", "贵州省", "海南省", "河北省", "河南省", "黑龙江省", "湖北省", "湖南省", "吉林省", "江苏省", "江西省", "辽宁省", "内蒙古自治区", "宁夏回族自治区", "青海省", "山东省", "山西省", "陕西省", "上海市", "四川省", "台湾省", "天津市", "西藏自治区", "香港", "新疆自治区", "云南省", "浙江省", "重庆市", "台湾"]
    
  end
end
