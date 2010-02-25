Given /^I am a visitor$/ do
  @current_user = nil  
end

Given /^I am a registered user with "([^\"]*)", "([^\"]*)" and "([^\"]*)"$/ do |arg1, arg2, arg3|
  @u = User.create!(:name => arg1, :email => arg2, :password => arg3)  
end

Given /^I am logged in$/ do
  u = User.create!(:name => "test", :email => "test@test.com", :password => "test123") 
  u.confirm!
  @session["warden.user.user.key"] = [u.class, u.id]
end






