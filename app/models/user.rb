class User < ActiveRecord::Base
  has_many :expenses, :dependent => :destroy
  has_many :categories
    
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :authenticatable, :confirmable, :recoverable,
         :rememberable, :trackable, :validatable
  
  acts_as_tagger
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[\d\w\s-]+$/i, :message => "Poate contine numai caracterele a..z, A..Z, 0..9, spatiu si -"
  
  # Named scopes
  named_scope :order_by_date, :order => 'created_at DESC'
  named_scope :with_eager_loading, :include => [:expenses, :categories] 
end
