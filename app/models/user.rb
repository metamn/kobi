class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :authenticatable, :confirmable, :recoverable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[\d\w-]+$/i, :message => "Poate contine numai caracterele a-zA-Z0-9"
end
