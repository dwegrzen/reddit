class User < ActiveRecord::Base

  has_many :links

  validates :username, presence: true
  
end
