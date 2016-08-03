class User < ActiveRecord::Base

  has_secure_password
  has_many :links
  has_many :votes

  validates :email, presence: true, uniqueness: true 
  validates :username, presence: true, uniqueness: true



  def to_param
    username
  end

end
