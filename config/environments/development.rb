# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# For Devise
config.action_mailer.default_url_options = { :host => 'localhost:3000' }

# For Gmail
ActionMailer::Base.smtp_settings = {  
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",  
  :port => 587,  
  :user_name => "hello.kobi@gmail.com",  
  :password => "mchrro10",  
  :authentication => :plain 
} 

# Do not load Gmail SMTP in development
config.plugins = config.plugin_locators.map do |locator|
  locator.new(Rails::Initializer.new(config)).plugins
end.flatten.map{|p| p.name.to_sym}
config.plugins -= [:gmail_smtp]
