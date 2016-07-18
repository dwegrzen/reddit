class User < ActiveRecord::Base

  has_many :links

  validates :username, presence: true


  def to_param
    username
  end

end
